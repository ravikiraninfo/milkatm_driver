import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:milkshop_driver/app/stop_list_view_page/stop_list_view_page.dart';

import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../refile_van_page/refill_page_model.dart';

class RouteMapPage extends StatefulWidget {
  const RouteMapPage({super.key});

  @override
  State<RouteMapPage> createState() => _RouteMapPageState();
}

class _RouteMapPageState extends State<RouteMapPage> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _fallbackCamera = CameraPosition(
    target: LatLng(23.0225, 72.5714),
    zoom: 12,
  );

  late final List<PickupPoint> pickupPoints;
  BitmapDescriptor? _pickupMarkerIcon;
  final Set<Marker> _pickupMarkers = {};
  Marker? _userMarker;
  LatLng? _userLatLng;
  String? _userAddress;
  bool _isMapReady = false;
  static const MarkerId _userMarkerId = MarkerId('user_location');
  StreamSubscription<Position>? _positionSubscription;
  LatLng? _lastReverseGeocodedLatLng;
  static const double _addressUpdateDistanceMeters = 50;

  @override
  void initState() {
    super.initState();
    pickupPoints = _resolvePickupPoints(Get.arguments);
    _initialiseMapContent();
  }

  List<PickupPoint> _resolvePickupPoints(dynamic args) {
    if (args is List<PickupPoint>) {
      return args;
    }
    if (args is List) {
      return args
          .map((point) => point is PickupPoint
              ? point
              : PickupPoint.fromJson(Map<String, dynamic>.from(point as Map)))
          .toList();
    }
    return [];
  }

  Future<void> _initialiseMapContent() async {
    await _loadPickupMarkerIcon();
    _refreshPickupMarkers();
    await _determinePosition();
  }

  Future<void> _loadPickupMarkerIcon() async {
    try {
      final BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(72, 72)),
        'assets/images/circle.png',
      );
      if (!mounted) return;
      setState(() {
        _pickupMarkerIcon = icon;
      });
    } catch (_) {
      // Default marker will be used if asset icon fails to load.
    }
  }

  void _refreshPickupMarkers() {
    final Set<Marker> updatedMarkers = {};
    for (final PickupPoint point in pickupPoints) {
      if (point.lat == null || point.long == null) {
        continue;
      }
      final String markerId = point.pickupPointId ?? point.name ?? '${point.lat}_${point.long}';
      updatedMarkers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: LatLng(point.lat!, point.long!),
          icon: _pickupMarkerIcon ?? BitmapDescriptor.defaultMarker,
          onTap: (){
            Get.to(()=>const StopListViewPage(),arguments: Get.arguments);
          },
          infoWindow: InfoWindow(
            title: point.name ?? 'Pickup Point',
            snippet: point.address,
            onTap: () {
              // TODO: Navigate to pickup-point detail page once available.
            },
          ),
        ),
      );
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _pickupMarkers
        ..clear()
        ..addAll(updatedMarkers);
    });
    _fitCameraToContent();
  }

  Future<void> _determinePosition() async {
    final bool granted = await _ensureLocationPermission();
    if (!granted) {
      return;
    }
    try {
      final Position? lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null && mounted) {
        await _updateUserLocation(
          LatLng(lastKnown.latitude, lastKnown.longitude),
          forceAddressUpdate: true,
        );
      }

      final Position position = await Geolocator.getCurrentPosition();
      if (!mounted) return;
      await _updateUserLocation(
        LatLng(position.latitude, position.longitude),
        forceAddressUpdate: lastKnown == null,
      );
      _startLocationStream();
    } catch (_) {
      // Current location will remain unavailable if fetching fails.
    }
  }

  Future<bool> _ensureLocationPermission() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  void _startLocationStream() {
    _positionSubscription?.cancel();
    final Stream<Position> positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    );
    _positionSubscription = positionStream.listen(
      (Position position) {
        final LatLng latLng = LatLng(position.latitude, position.longitude);
        if (!mounted) {
          return;
        }
        unawaited(_updateUserLocation(latLng));
      },
      onError: (_) {
        // Stream errors are ignored; last known good location stays on screen.
      },
    );
  }

  Future<void> _fitCameraToContent() async {
    if (!_isMapReady) {
      return;
    }

    final List<LatLng> positions = _pickupMarkers.map((Marker marker) => marker.position).toList();
    if (_userLatLng != null) {
      positions.add(_userLatLng!);
    }

    if (positions.isEmpty) {
      return;
    }

    final GoogleMapController mapController = await _controller.future;
    if (positions.length == 1) {
      await mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: positions.first, zoom: 15),
        ),
      );
      return;
    }

    final LatLngBounds bounds = _calculateBounds(positions);
    await mapController.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 60),
    );
  }

  LatLngBounds _calculateBounds(List<LatLng> positions) {
    double? south;
    double? north;
    double? west;
    double? east;

    for (final LatLng latLng in positions) {
      south = south == null ? latLng.latitude : (latLng.latitude < south ? latLng.latitude : south);
      north = north == null ? latLng.latitude : (latLng.latitude > north ? latLng.latitude : north);
      west = west == null ? latLng.longitude : (latLng.longitude < west ? latLng.longitude : west);
      east = east == null ? latLng.longitude : (latLng.longitude > east ? latLng.longitude : east);
    }

    // Guard against identical coordinates to keep bounds valid.
    if (south == north) {
      south = south! - 0.0005;
      north = north! + 0.0005;
    }
    if (west == east) {
      west = west! - 0.0005;
      east = east! + 0.0005;
    }

    return LatLngBounds(
      southwest: LatLng(south!, west!),
      northeast: LatLng(north!, east!),
    );
  }

  Future<void> _updateUserLocation(LatLng position, {bool forceAddressUpdate = false}) async {
    final bool positionChanged = _userLatLng?.latitude != position.latitude || _userLatLng?.longitude != position.longitude;
    final Marker marker = Marker(
      markerId: _userMarkerId,
      position: position,
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: const InfoWindow(title: 'Current Location'),
    );

    if (!mounted) {
      return;
    }

    if (positionChanged || _userMarker == null) {
      setState(() {
        _userLatLng = position;
        _userMarker = marker;
      });
      _fitCameraToContent();
    }

    await _resolveUserAddress(position, forceUpdate: forceAddressUpdate);
  }

  Future<void> _resolveUserAddress(LatLng position, {bool forceUpdate = false}) async {
    if (!forceUpdate && _lastReverseGeocodedLatLng != null) {
      final double distance = Geolocator.distanceBetween(
        _lastReverseGeocodedLatLng!.latitude,
        _lastReverseGeocodedLatLng!.longitude,
        position.latitude,
        position.longitude,
      );
      if (distance < _addressUpdateDistanceMeters) {
        return;
      }
    }

    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (!mounted) {
        return;
      }

      final String? formattedAddress = _formatPlacemark(placemarks.isNotEmpty ? placemarks.first : null);
      setState(() {
        _userAddress = formattedAddress;
        _lastReverseGeocodedLatLng = position;
      });
    } catch (_) {
      // Address lookup failed; keep showing fallback coordinates.
    }
  }

  String? _formatPlacemark(Placemark? placemark) {
    if (placemark == null) {
      return null;
    }

    final List<String> segments = [];
    void addSegment(String? value) {
      if (value == null) {
        return;
      }
      final String trimmed = value.trim();
      if (trimmed.isNotEmpty && !segments.contains(trimmed)) {
        segments.add(trimmed);
      }
    }

    addSegment(placemark.street);
    addSegment(placemark.subLocality);
    addSegment(placemark.locality);
    addSegment(placemark.administrativeArea);
    addSegment(placemark.postalCode);
    addSegment(placemark.country);

    if (segments.isEmpty) {
      return null;
    }
    return segments.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColor.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 14.h),
              child: Row(
                children: [
                  InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Image.asset('assets/images/back.png',height: 34.h,width: 34.h,)),
                  w(10),
                  Text('Route Map View',style: AppTextStyle.medium20(AppColor.whiteColor),),
                  spacer(),
                  Image.asset('assets/images/notification.png',height: 20.h,width: 20 .h,),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _fallbackCamera,
                    markers: {
                      ..._pickupMarkers,
                      if (_userMarker != null) _userMarker!,
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      if (!_controller.isCompleted) {
                        _controller.complete(controller);
                      }
                      _isMapReady = true;
                      _fitCameraToContent();
                    },
                  ),
                  Container(
                    color: AppColor.whiteColor,
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 24.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on,color: AppColor.blackColor,size: 30.h,),
                        w(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Current location',style: AppTextStyle.medium16(AppColor.blackColor),),
                              h(4),
                              Text(
                                _userAddress ??
                                    (_userLatLng != null
                                        ? '${_userLatLng!.latitude.toStringAsFixed(5)}, ${_userLatLng!.longitude.toStringAsFixed(5)}'
                                        : 'Detecting location...'),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.regular14(AppColor.greyColor),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }
}
