import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';



class RouteMapPage extends StatefulWidget {
  const RouteMapPage({super.key});

  @override
  State<RouteMapPage> createState() => _RouteMapPageState();
}

class _RouteMapPageState extends State<RouteMapPage> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

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
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  Container(
                    // height: 150.h,
                    color: AppColor.whiteColor,
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 24.h),
                    child: Row(
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
                                'Flat No. 57, IOC Rd, opposite Hanumanji Mandir, Akash Ganga Society, Chandkheda, Ahmedabad, Gujarat 382424',
                                maxLines: 3,
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
}
