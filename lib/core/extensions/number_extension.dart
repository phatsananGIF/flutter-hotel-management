import 'package:intl/intl.dart';

extension NumberExtension on num {
  String toPriceFormat() {
    NumberFormat nf = NumberFormat("#,##0.00");

    return nf.format(this);
  }
}
