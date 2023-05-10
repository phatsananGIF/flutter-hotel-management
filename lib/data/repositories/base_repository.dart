import 'package:dio/dio.dart';

import '../../core/network/exceptions/bad_network_api_exception.dart';
import '../../core/network/exceptions/unauthorized_api_exception.dart';

abstract class BaseRepository {
  dio2curl(RequestOptions requestOption) {
    var curl = '';

    // Add PATH + REQUEST_METHOD
    curl +=
        'curl --request ${requestOption.method} \'${requestOption.baseUrl}${requestOption.path}\'';

    // Include headers
    for (var key in requestOption.headers.keys) {
      curl += ' -H \'$key: ${requestOption.headers[key]}\'';
    }

    // Include data if there is data
    if (requestOption.data != null) {
      curl += ' --data-binary \'${requestOption.data}\'';
    }

    curl += ' --insecure'; //bypass https verification
    print("-------- cURL --------");
    print(curl);
    print("----------------------");
  }
}

extension ResponseExtension on Response {
  Response responseHandler() {
    if (this.statusCode == 200 || this.statusCode == 204) {
      return this;
    } else if (statusCode == 401) {
      throw UnAutherizedApiException();
    } else {
      throw BadNetworkApiException();
    }
  }
}
