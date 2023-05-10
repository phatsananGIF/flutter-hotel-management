import 'package:dio/dio.dart';

class UnAuthorizedApiError extends DioError {
  UnAuthorizedApiError(RequestOptions options) : super(requestOptions: options);
}
