import 'package:flutter/material.dart';

import '../../core/i18n/translations.g.dart';
import '../../core/styles/color.dart';
import '../../core/styles/sarabun_font.dart';
import '../../core/styles/screen_dimensions.dart';

class WgButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? textColor;

  const WgButton({
    Key? key,
    this.onPressed,
    this.text,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: this.onPressed,
        child: Text(
          this.text ?? AppLocalizations.global.ok,
          style: SBFont.medium16.copyWith(
            color: textColor ?? Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: SCDimens.dimen12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: backgroundColor ?? Color(PRIMARY_COLOR),
          disabledBackgroundColor: disabledBackgroundColor ?? null,
          foregroundColor: Color(PRIMARY900_COLOR),
          disabledForegroundColor: Color(SECOND300_COLOR),
        ),
      ),
    );
  }
}
