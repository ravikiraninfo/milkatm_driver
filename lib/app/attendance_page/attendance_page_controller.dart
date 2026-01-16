import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:milkshop_driver/app/refile_van_page/refile_van_page.dart';
import 'package:milkshop_driver/data/local/shared_preference/shared_preference.dart';
import 'package:milkshop_driver/data/local/shared_preference/shared_preference_key.dart';
import '../../api/api_url.dart';
import '../../common/common_snackbar.dart';
import '../../global/global.dart';
import '../../services/base_services.dart';
class AttendancePageController extends GetxController {
  Future<d.Response?> startDay()async{
    CustomSnackBar.showAlertDialog(Get.context!);
    d.Response? response = await BaseService().post(ApiUrl.attendanceClockIn,data: {
      "driverUserId": MySharedPref.getString(PreferenceKey.driverID),
      "clockInTime": DateTime.now().toIso8601String(),
      "clockOutLocation": {
        "latitude": 0,
        "longitude": 0
      },
      "notes": ""
    },);
    if (response?.statusCode == 200) {
      Get.back();
      Global.dayStarted.value==true;
      CustomSnackBar.showToast(
        Get.context!,
        messages:response?.data['message'] ?? 'Success',
      );
      Get.to(()=>RefileVanPage());
      return response;
    }else{
      CustomSnackBar.showToast(
        Get.context!,
        messages:response?.data['message'] ?? "Something went wrong",
      );
      Get.back();
    }
    return null;
  }
  Future<d.Response?> endDay()async{
    CustomSnackBar.showAlertDialog(Get.context!);
    d.Response? response = await BaseService().post(ApiUrl.attendanceClockOut,data: {
      "driverUserId": MySharedPref.getString(PreferenceKey.driverID),
      "clockOutTime": DateTime.now().toIso8601String(),
      "clockOutLocation": {
        "latitude": 0,
        "longitude": 0
      },
      "notes": ""
    },);
    if (response?.statusCode == 200) {
      Get.back();
      Global.dayStarted.value==true;
      CustomSnackBar.showToast(
        Get.context!,
        messages:response?.data['message'] ?? 'Success',
      );
      Get.to(()=>RefileVanPage());
      return response;
    }else{
      CustomSnackBar.showToast(
        Get.context!,
        messages:response?.data['message'] ?? "Something went wrong",
      );
      Get.back();
    }
    return null;
  }
}