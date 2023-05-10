import 'dart:ffi';

import '../network/exceptions/api_error_exception.dart';


class ExceptionUtil {
  static messageHandler(Object err) {
    if (err is ApiErrorException) {
      return err.msg;
    }
    return "$err";
  }
}
