import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/common_flex.dart';
import '../../common/common_snackbar.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';

class CameraImagePage extends StatefulWidget {
  const CameraImagePage({super.key});

  @override
  State<CameraImagePage> createState() => _CameraImagePageState();
}

class _CameraImagePageState extends State<CameraImagePage> {
  CameraController? controller;
  List<CameraDescription> _cameras = [];
  String? _capturedImagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      controller = CameraController(_cameras[0], ResolutionPreset.max);
      await controller!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            CustomSnackBar.showToast(
              Get.context,
              messages: 'Camera access denied',
            );
            break;
          default:
            CustomSnackBar.showToast(
              Get.context,
              messages: 'Camera error: ${e.description}',
            );
            break;
        }
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container(
        alignment: Alignment.center,
        color: AppColor.whiteColor,
        child: CircularProgressIndicator(color: AppColor.primaryColor),
      );
    }
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.blackColor,
        body: _capturedImagePath != null? Column(
          children: [
            spacer(),
            Image.file(File(_capturedImagePath!)),
            spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: AppColor.whiteColor,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _capturedImagePath = null;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.check,
                    color: AppColor.whiteColor,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.pop(context, _capturedImagePath);
                  },
                ),

              ],
            ),
            h(20.h),
          ],
        ):Column(
          children: [
            Transform.scale(
                scale: controller!.value.aspectRatio/deviceRatio*0.6,
                alignment: Alignment.center,
                child: CameraPreview(controller!)),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    controller!.value.flashMode == FlashMode.torch
                        ? Icons.flash_on
                        : Icons.flash_off,
                    color: AppColor.whiteColor,
                    size: 40,
                  ),
                  onPressed: () async {
                    if (controller!.value.flashMode == FlashMode.off) {
                      await controller!.setFlashMode(FlashMode.torch);
                    } else {
                      await controller!.setFlashMode(FlashMode.off);
                    }
                    setState(() {});
                  },
                ),
                InkWell(
                  onTap: () async {
                    try {
                      final image = await controller!.takePicture();
                      setState(() {
                        _capturedImagePath = image.path;
                      });
                    } catch (e) {
                      CustomSnackBar.showToast(
                        Get.context,
                        messages: 'Error taking picture: $e',
                      );
                    }
                  },
                  child: Ink(
                    height: 60.h,
                    width: 60.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.switch_camera,
                    color: AppColor.whiteColor,
                    size: 40,
                  ),
                  onPressed: () async {
                    if (_cameras.length > 1) {
                      int newIndex =
                          (_cameras.indexOf(controller!.description) + 1) %
                              _cameras.length;
                      controller = CameraController(
                        _cameras[newIndex],
                        ResolutionPreset.max,
                      );
                      await controller!.initialize();
                      setState(() {});
                    } else {
                      CustomSnackBar.showToast(
                        Get.context,
                        messages: 'No secondary camera available',
                      );
                    }
                  },
                ),
              ],
            ),
            h(16.h),
          ],
        ),
      ),
    );
  }
}


class CameraVideoPage extends StatefulWidget {
  const CameraVideoPage({super.key});

  @override
  State<CameraVideoPage> createState() => _CameraVideoPageState();
}


class _CameraVideoPageState extends State<CameraVideoPage> {
  CameraController? controller;
  List<CameraDescription> _cameras = [];
  String? _capturedVideoPath;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      controller = CameraController(_cameras[0], ResolutionPreset.max);
      await controller!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            CustomSnackBar.showToast(
              Get.context,
              messages: 'Camera access denied',
            );
            break;
          default:
            CustomSnackBar.showToast(
              Get.context,
              messages: 'Camera error: ${e.description}',
            );
            break;
        }
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container(
        alignment: Alignment.center,
        color: AppColor.whiteColor,
        child: CircularProgressIndicator(color: AppColor.primaryColor),
      );
    }
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.blackColor,
        body:  Column(
          children: [
            Transform.scale(
                scale: controller!.value.aspectRatio/deviceRatio*0.6,
                alignment: Alignment.center,
                child: CameraPreview(controller!)),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    controller!.value.flashMode == FlashMode.torch
                        ? Icons.flash_on
                        : Icons.flash_off,
                    color: AppColor.whiteColor,
                    size: 40,
                  ),
                  onPressed:_isRecording ?null: () async {
                    if (controller!.value.flashMode == FlashMode.off) {
                      await controller!.setFlashMode(FlashMode.torch);
                    } else {
                      await controller!.setFlashMode(FlashMode.off);
                    }
                    setState(() {});
                  },
                ),
                InkWell(
                  onTap: () async {
                    if (_isRecording) {
                      try {
                        final video = await controller!.stopVideoRecording();
                        setState(() {
                          _isRecording = false;
                          _capturedVideoPath = video.path;
                        });
                        if(_capturedVideoPath != null) {
                          Navigator.pop(context, _capturedVideoPath);
                        }
                      } catch (e) {
                        CustomSnackBar.showToast(
                          Get.context,
                          messages: 'Error stopping video recording: $e',
                        );
                      }
                    } else {
                      try {
                        await controller!.startVideoRecording();
                        setState(() {
                          _isRecording = true;
                        });
                      } catch (e) {
                        CustomSnackBar.showToast(
                          Get.context,
                          messages: 'Error starting video recording: $e',
                        );
                      }
                    }
                  },
                  child: Ink(
                    height: 60.h,
                    width: 60.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isRecording ? AppColor.redColor : AppColor.whiteColor,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.switch_camera,
                    color: AppColor.whiteColor,
                    size: 40,
                  ),
                  onPressed:  _isRecording ?null:() async {
                    if (_cameras.length > 1) {
                      int newIndex = (_cameras.indexOf(controller!.description) + 1) % _cameras.length;
                      controller = CameraController(_cameras[newIndex], ResolutionPreset.max);
                      await controller!.initialize();
                      setState(() {});
                    } else {
                      CustomSnackBar.showToast(
                        Get.context,
                        messages: 'No secondary camera available',
                      );
                    }
                  },
                ),
              ],
            ),
            h(16.h),
          ],
        ),
      ),
    );
  }
}

