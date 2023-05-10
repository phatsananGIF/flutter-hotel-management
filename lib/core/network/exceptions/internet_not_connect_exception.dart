
import '../../utils/print_util.dart';

class InternetNotConnect implements Exception {
  InternetNotConnect() {
    dPrint('Internet Not Connect!');
  }
}
