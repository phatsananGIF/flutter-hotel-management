import 'package:dio/dio.dart';

class BadNetworkApiError extends DioError {
  BadNetworkApiError(RequestOptions options) : super(requestOptions: options);
}
