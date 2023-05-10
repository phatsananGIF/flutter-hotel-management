import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/network/exceptions/internet_not_connect_exception.dart';
import '../../../core/network/network_info.dart';
import '../../../core/utils/print_util.dart';
import '../../../core/utils/shared_preferences_util.dart';
import '../../../domain/entities/app_flavor_data.dart';

@injectable
class ApiInterceptors implements InterceptorsWrapper {
  final NetworkInfo _networkInfo = NetworkInfo();
  @factoryParam
  final SharedPreferencesUtil? _sharedPreferencesUtil;
  @factoryParam
  final AppFlavorData _appFlavorData;

  ApiInterceptors(this._sharedPreferencesUtil, this._appFlavorData);

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    _printErrorData(err);

    if (err.response?.statusCode == 401) {
    } else {
      handler.reject(err);
    }
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!(await _networkInfo.isConnected)) {
      throw InternetNotConnect();
    }

    final String? accessToken = _sharedPreferencesUtil
            ?.getString(SharedPreferencesUtil.keyAccessToken) ??
        '';

    if (!options.path.contains("http://") && !options.path.contains("https://"))
      options.baseUrl = Uri.encodeFull(_appFlavorData.apiEndpoint);

    options.headers['Authorization'] = 'Bearer $accessToken';
    options.headers['content-type'] = Headers.jsonContentType;
    options.headers['accept'] = Headers.jsonContentType;

    _printRequestData(options);

    handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    _printResponseData(response);

    handler.next(response);
  }

  _printRequestData(RequestOptions options) {
    dPrint(
        "Request : ${options.method.toUpperCase()} --> ${options.baseUrl}${options.path}");
    dPrint("Headers:");
    options.headers.forEach((k, v) => print('$k: $v'));
    if (options.queryParameters.isNotEmpty) {
      dPrint("queryParameters:");
      options.queryParameters.forEach((k, v) => print('$k: $v'));
    }
    if (options.data != null) {
      dPrint("Body: ${options.data}");
    }

    dPrint("--> END");
  }

  _printResponseData(Response response) {
    dPrint(
        "<-- ${response.statusCode} : ${(response.requestOptions.baseUrl) + (response.requestOptions.path)}");
    dPrint("Headers:");
    response.headers.forEach((k, v) => print('$k: $v'));
    dPrint("Response: ${response.data}");
    dPrint("<-- END");
  }

  _printErrorData(DioError err) {
    dPrint(
        "<--${err.response?.statusCode ?? '' + " : "}  ${err.message} ${(err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL')}");
    dPrint("${err.response != null ? err.response!.data : 'Unknown Error'}");
    dPrint("<-- End error");
  }
}
