import 'package:dio/src/dio_error.dart';

class ApiErrorException implements Exception {
  String msg = "";
  ApiErrorException(DioError err) {
    print("ApiErrorException => ${err.response?.statusCode}");
    print("ApiErrorException => ${err.response?.data}");

    if (err.response?.data != null && err.response?.data != null) {
      msg = err.response?.data;
    } else {
      msg = err.message;
    }
  }
}
