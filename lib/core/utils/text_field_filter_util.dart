import 'package:flutter/services.dart';

class TextFieldFilterUtil {
  static final numberOnly = FilteringTextInputFormatter.allow(
    RegExp('[0-9]'),
  );
  static final numberAndDecimal = FilteringTextInputFormatter.allow(
    RegExp('[0-9.]'),
  );
  static final startNoneZero = FilteringTextInputFormatter.deny(
    RegExp(r'^0+'),
  );
}
