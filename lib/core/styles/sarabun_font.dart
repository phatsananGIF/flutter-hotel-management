import 'package:flutter/widgets.dart';

import 'color.dart';
import 'screen_font_size.dart';

class SBFont {
  static final TextStyle _baseRegularFont = TextStyle(
    fontFamily: 'Sarabun-Regular',
    fontSize: SCFontSize.size14,
    color: const Color(BLACK_COLOR),
    height: 1.2,
  );

  static final TextStyle _baseMediumFont = _baseRegularFont.copyWith(
    fontFamily: 'Sarabun-Medium',
    fontWeight: FontWeight.w500,
  );

  static final TextStyle _baseSemiBoldFont = _baseRegularFont.copyWith(
    fontFamily: 'Sarabun-SemiBold',
    fontWeight: FontWeight.w600,
  );

  static final TextStyle _baseBoldFont = _baseRegularFont.copyWith(
    fontFamily: 'Sarabun-Bold',
    fontWeight: FontWeight.w700,
  );
  static final regular10 =
      _baseRegularFont.copyWith(fontSize: SCFontSize.size10);
  static final regular12 =
      _baseRegularFont.copyWith(fontSize: SCFontSize.size12);
  static final regular14 = _baseRegularFont;
  static final regular16 =
      _baseRegularFont.copyWith(fontSize: SCFontSize.size16);
  static final regular18 =
      _baseRegularFont.copyWith(fontSize: SCFontSize.size18);
  static final regular20 =
      _baseRegularFont.copyWith(fontSize: SCFontSize.size20);
  static final regular24 =
      _baseRegularFont.copyWith(fontSize: SCFontSize.size24);
  static final regular30 =
      _baseRegularFont.copyWith(fontSize: SCFontSize.size30);

  //medium
  static final medium10 = _baseMediumFont.copyWith(fontSize: SCFontSize.size10);
  static final medium12 = _baseMediumFont.copyWith(fontSize: SCFontSize.size12);
  static final medium14 = _baseMediumFont.copyWith(fontSize: SCFontSize.size14);
  static final medium16 = _baseMediumFont.copyWith(fontSize: SCFontSize.size16);
  static final medium18 = _baseMediumFont.copyWith(fontSize: SCFontSize.size18);
  static final medium24 = _baseMediumFont.copyWith(fontSize: SCFontSize.size24);
  static final medium30 = _baseMediumFont.copyWith(fontSize: SCFontSize.size30);
  static final medium34 = _baseMediumFont.copyWith(fontSize: SCFontSize.size34);
  static final medium50 = _baseMediumFont.copyWith(fontSize: SCFontSize.size50);

  //semi-bold
  static final semiBold10 =
      _baseSemiBoldFont.copyWith(fontSize: SCFontSize.size10);
  static final semiBold12 =
      _baseSemiBoldFont.copyWith(fontSize: SCFontSize.size12);
  static final semiBold14 =
      _baseSemiBoldFont.copyWith(fontSize: SCFontSize.size14);
  static final semiBold16 =
      _baseSemiBoldFont.copyWith(fontSize: SCFontSize.size16);
  static final semiBold18 =
      _baseSemiBoldFont.copyWith(fontSize: SCFontSize.size18);
  static final semiBold20 =
      _baseSemiBoldFont.copyWith(fontSize: SCFontSize.size20);
  static final semiBold24 =
      _baseSemiBoldFont.copyWith(fontSize: SCFontSize.size24);
  static final semiBold28 =
      _baseSemiBoldFont.copyWith(fontSize: SCFontSize.size28);
  static final semiBold30 =
      _baseSemiBoldFont.copyWith(fontSize: SCFontSize.size30);
  static final semiBold32 =
      _baseSemiBoldFont.copyWith(fontSize: SCFontSize.size32);
  static final semiBold40 =
      _baseSemiBoldFont.copyWith(fontSize: SCFontSize.size40);

  //bold
  static final bold12 = _baseBoldFont.copyWith(fontSize: SCFontSize.size12);
  static final bold14 = _baseBoldFont.copyWith(fontSize: SCFontSize.size14);
  static final bold16 = _baseBoldFont.copyWith(fontSize: SCFontSize.size16);
  static final bold18 = _baseBoldFont.copyWith(fontSize: SCFontSize.size18);
  static final bold20 = _baseBoldFont.copyWith(fontSize: SCFontSize.size20);
  static final bold30 = _baseBoldFont.copyWith(fontSize: SCFontSize.size30);
}
