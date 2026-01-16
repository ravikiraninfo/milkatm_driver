import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:milkshop_driver/app/refile_van_page/refill_page_model.dart';
import 'package:milkshop_driver/data/local/shared_preference/shared_preference.dart';
import 'package:milkshop_driver/data/local/shared_preference/shared_preference_key.dart';
import '../../api/api_url.dart';
import '../../common/common_snackbar.dart';
import '../../services/base_services.dart';
class RefillPageController extends GetxController {
  Rx<VanDetails> vanDetails = VanDetails().obs;

  RxBool isLoading = false.obs;
  Future<d.Response?> startRoute()async{
    isLoading.value = true;
    d.Response? response = await BaseService().get(ApiUrl.vanRoutes(MySharedPref.getString(PreferenceKey.driverID)));
    if (response?.statusCode == 200) {
      isLoading.value = false;
      vanDetails.value = VanDetails.fromJson(response!.data);
      return response;
    }else{
      isLoading.value = false;
      CustomSnackBar.showToast(
        Get.context!,
        messages:response?.data['message'] ?? "Something went wrong",
      );
    }
    return null;
  }
@override
  void onInit() {
    startRoute();
    super.onInit();
  }

}