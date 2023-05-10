import 'package:flutter/material.dart';

import '../../core/styles/sarabun_font.dart';
import '../../core/styles/screen_dimensions.dart';

class WgNotFound extends StatelessWidget {
  const WgNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: SCDimens.dimen100),
        Text(
          "ไม่พบข้อมูล",
          style: SBFont.regular14.copyWith(
            color: Color(0xFFD0D0D0),
          ),
        ),
      ],
    );
  }
}
