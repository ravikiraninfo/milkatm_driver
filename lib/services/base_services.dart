import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as g;
import 'package:milkshop_driver/services/print_api_name_and_response.dart';
import '../common/common_snackbar.dart';
import '../data/local/shared_preference/shared_preference.dart';
import '../data/local/shared_preference/shared_preference_key.dart';

class BaseService {
  String? token= MySharedPref.getString(PreferenceKey.token);
  Dio getDio() {
    Dio dio = Dio();

    dio.options.headers["Content-Type"] = "application/json";
    if (token != null) {
      dio.options.headers["authorization"] = "Bearer $token";
    }

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }

  Future<Response?> get(String url, {Map<String, dynamic>? queryParameters,Map<String, dynamic>? data,bool isShowMessage = false,String? messages}) async {
    // if (!_canCallApi(url, cooldownMs: 2000)) return null;
    Dio dio = getDio();
    try {
      final Response response = await dio.get(url, queryParameters: queryParameters,data: data);
      PrintAPINameAndResponse.printAPINameResponse(apiName: 'GET', apiUrl: url, response: response);
      if(response.statusCode == 200) {
        if(isShowMessage) {
          CustomSnackBar.showToast(g.Get.context, messages: messages??response.data["message"]??"");
        }
      }
      return response;
    } on DioException catch(ex) {
      if(ex.response != null) {
        PrintAPINameAndResponse.printAPIErrorResponse(
            apiUrl: url, response: ex.response!);
        if(isShowMessage) {
          CustomSnackBar.showToast(g.Get.context, messages: ex.response!.data["message"]??"");
        }
        return ex.response!;
      }
      if (kDebugMode) {
        log("Error statusCode => ${ex.response?.statusCode}");
        log("Error data => ${ex.response?.data}");
        String errorMessage = DioExceptionHandler.handleError(ex);
        log('API Request Error: $errorMessage');
      }
      throw Exception("Failed to perform GET request: $ex");
    }
  }

  Future<Response?> post(String url, {dynamic data,bool isShowMessage = false,Options? options}) async {
    // if (!_canCallApi(url, cooldownMs: 2000)) return null;
    Dio dio = getDio();
    try {
      final Response response = await dio.post(url, data: data,options: options);
      if(response.statusCode == 200) {
        if(isShowMessage) {
          CustomSnackBar.showToast(g.Get.context, messages:response.data["message"]??"");
        }
      }
      PrintAPINameAndResponse.printAPINameResponse(apiName: 'POST', apiUrl: url, response: response);
      return response;
    } on DioException catch(ex) {
      if(ex.response != null) {
        PrintAPINameAndResponse.printAPIErrorResponse(
            apiUrl: url, response: ex.response!
        );
        if(isShowMessage) {
          CustomSnackBar.showToast(g.Get.context, messages:ex.response?.data["message"]??"");
        }
        return ex.response!;
      }
      String errorMessage = DioExceptionHandler.handleError(ex);
      if (kDebugMode) {
        print('API Request Error: $errorMessage');
      }
      if(errorMessage=="Connection timeout with API server"){
        CustomSnackBar.showToast(g.Get.context, messages: "Connection timeout with API server");
        g.Get.back();
      }else{
        CustomSnackBar.showToast(g.Get.context, messages :ex.response?.data["message"]);
      }
      throw Exception("Failed to perform POST request: $ex");
    }
  }

  Future<Response> put(String url, {dynamic data,isShowMessage = true,String? messages}) async {
    Dio dio = getDio();
    try {
      final Response response = await dio.put(url, data: data);
      PrintAPINameAndResponse.printAPINameResponse(apiName: 'PUT', apiUrl: url, response: response);
      if(response.statusCode == 200) {
        if(isShowMessage) {
          CustomSnackBar.showToast(g.Get.context, messages: messages??"");
        }
      }
      return response;
    } on DioException catch(ex) {
      if(ex.response != null) {
        PrintAPINameAndResponse.printAPIErrorResponse(
            apiUrl: url, response: ex.response!);
        if(isShowMessage) {
          CustomSnackBar.showToast(g.Get.context, messages: messages??"");
        }
        return ex.response!;
      }
      if (kDebugMode) {
        String errorMessage = DioExceptionHandler.handleError(ex);
        print('API Request Error: $errorMessage');

      }
      throw Exception("Failed to perform PUT request: $ex");
    }
  }

  Future<Response> delete(String url, {dynamic data,bool isShowMessage = true,String? messages}) async {
    Dio dio = getDio();
    try {
      final Response response = await dio.delete(url, data: data);
      if(response.statusCode == 200) {
        CustomSnackBar.showToast(g.Get.context, messages: "Deleted Successfully");
      }
      PrintAPINameAndResponse.printAPINameResponse(apiName: 'DELETE', apiUrl: url, response: response);

      return response;
    } on DioException catch(ex) {
      if(ex.response != null) {
        PrintAPINameAndResponse.printAPIErrorResponse(
            apiUrl: url, response: ex.response!);
        if(isShowMessage) {
          CustomSnackBar.showToast(g.Get.context, messages: messages??"");
        }
        return ex.response!;
      }
      if (kDebugMode) {
        String errorMessage = DioExceptionHandler.handleError(ex);
        print('API Request Error: $errorMessage');

      }
      throw Exception("Failed to perform DELETE request: $ex");
    }
  }

  Future<void> downloadFile(String url, String savePath, {Function(int, int)? onReceiveProgress}) async {
    Dio dio = getDio();
    try {
      await dio.download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
      );
      CustomSnackBar.showToast(g.Get.context, messages: "File downloaded successfully");
    } on DioException catch (ex) {
      if (kDebugMode) {
        log("Download error: ${ex.message}");
      }
      CustomSnackBar.showToast(g.Get.context, messages: "Failed to download file");
    }
  }
}


class DioExceptionHandler {
  static String handleError(dynamic error) {
    String errorDescription = '';
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          errorDescription = 'Request to API server was canceled';
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = 'Connection timeout with API server';
          break;
        case DioExceptionType.unknown:
          errorDescription = 'Unknown error occurred';
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = 'Receive timeout in connection with API server';
          break;
        case DioExceptionType.badResponse:
          errorDescription =
              _handleResponseError(error.response?.statusCode!);
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = 'Send timeout in connection with API server';
          break;
        case DioExceptionType.badCertificate:
          errorDescription = 'Bad Certificate error occurred';
          break;
        case DioExceptionType.connectionError:
          errorDescription = 'Connection error occurred';
          break;
      }
    } else {
      errorDescription = 'Unexpected error occurred';
    }

    return errorDescription;
  }

  static String _handleResponseError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Received invalid status code: $statusCode';
    }
  }
}