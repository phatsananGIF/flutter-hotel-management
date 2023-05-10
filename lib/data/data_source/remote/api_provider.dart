import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/network/errors/bad_network_api_error.dart';
import '../../../core/network/errors/unauthorized_api_error.dart';
import '../../../core/network/exceptions/api_error_exception.dart';
import '../../../core/network/exceptions/bad_network_api_exception.dart';
import '../../../core/network/exceptions/unauthorized_api_exception.dart';
import 'api_interceptors.dart';

@injectable
class ApiProvider {
  final ApiInterceptors _interceptors;
  final Dio _dio = new Dio();

  ApiProvider(this._interceptors) {
    _dio.interceptors.clear();
    _dio.interceptors.add(this._interceptors);
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response res = await _dio.get(path, queryParameters: queryParameters);

      return res;
    } on BadNetworkApiError {
      throw BadNetworkApiException();
    } on UnAuthorizedApiError {
      throw UnAutherizedApiException();
    } on DioError catch (err) {
      throw ApiErrorException(err);
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? body}) async {
    try {
      Response res = await _dio.post(path, data: jsonEncode(body));

      return res;
    } on BadNetworkApiError {
      throw BadNetworkApiException();
    } on UnAuthorizedApiError {
      throw UnAutherizedApiException();
    } on DioError catch (e) {
      throw ApiErrorException(e);
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? body}) async {
    try {
      Response res = await _dio.put(path, data: jsonEncode(body));

      return res;
    } on BadNetworkApiError {
      throw BadNetworkApiException();
    } on UnAuthorizedApiError {
      throw UnAutherizedApiException();
    } on DioError catch (e) {
      throw ApiErrorException(e);
    }
  }

  Future<Response> patch(String path, {Map<String, dynamic>? body}) async {
    try {
      Response res = await _dio.patch(path, data: jsonEncode(body));

      return res;
    } on BadNetworkApiError {
      throw BadNetworkApiException();
    } on UnAuthorizedApiError {
      throw UnAutherizedApiException();
    } on DioError catch (e) {
      throw ApiErrorException(e);
    }
  }

  Future<Response> delete(String path, {Map<String, dynamic>? body}) async {
    try {
      Response res = await _dio.delete(path, queryParameters: body);

      return res;
    } on BadNetworkApiError {
      throw BadNetworkApiException();
    } on UnAuthorizedApiError {
      throw UnAutherizedApiException();
    } on DioError catch (e) {
      throw ApiErrorException(e);
    }
  }

  Future<Response> getUri(Uri uri) async {
    try {
      Response res = await _dio.getUri(uri);

      return res;
    } on BadNetworkApiError {
      throw BadNetworkApiException();
    } on UnAuthorizedApiError {
      throw UnAutherizedApiException();
    } on DioError catch (err) {
      throw ApiErrorException(err);
    }
  }

  Future<Response> getRefreshToken(String refreshToken) async {
    try {
      // FormData data = FormData();

      // data.fields.add(MapEntry("refresh_token", refreshToken));

      return await _dio.post("/dohome-dodee/v1/authen/oauth2/refresh-token",
          data: {"refresh_token": refreshToken});
    } on BadNetworkApiError {
      throw BadNetworkApiException();
    } on UnAuthorizedApiError {
      throw UnAutherizedApiException();
    } on DioError catch (e) {
      throw ApiErrorException(e);
    }
  }

  cancelRequest() {
    _dio.close(force: true);
  }
}
