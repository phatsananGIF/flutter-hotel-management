import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/styles/color.dart';
import '../../core/styles/sarabun_font.dart';
import '../../core/styles/screen_dimensions.dart';

class WgTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  const WgTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      focusNode: focusNode,
      enabled: this.enabled,
      style: SBFont.regular16,
      cursorColor: Color(SECOND900_COLOR),
      textAlign: textAlign,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(WHITE_COLOR),
        hintText: this.hintText,
        isDense: true,
        hintStyle: SBFont.regular16.copyWith(
          color: Color(NEUTRAL500_COLOR),
        ),
        contentPadding: EdgeInsets.all(SCDimens.dimen16),
        enabledBorder: _border(),
        disabledBorder: _border().copyWith(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
        ),
        focusedBorder: _border(),
      ),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: this.validator,
      keyboardType: this.keyboardType,
      inputFormatters: this.inputFormatters,
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(NEUTRAL300_COLOR),
      ),
    );
  }
}
