import 'package:flutter/material.dart';

import '../../../../core/styles/color.dart';
import '../../../../core/styles/sarabun_font.dart';
import '../../../../core/styles/screen_dimensions.dart';

class HomeBt extends StatelessWidget {
  final VoidCallback? onPressedCheckIn;
  final VoidCallback? onPressedCheckOut;

  const HomeBt({
    Key? key,
    this.onPressedCheckIn,
    this.onPressedCheckOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(WHITE_COLOR),
        borderRadius: BorderRadius.all(
          Radius.circular(SCDimens.dimen6),
        ),
      ),
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.all(SCDimens.dimen10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: onPressedCheckIn,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Color(BLACK_COLOR),
                        size: SCDimens.dimen24,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: SCDimens.dimen10),
                        child: Text(
                          "เช็คอิน",
                          style: SBFont.regular14.copyWith(
                            color: Color(BLACK_COLOR),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              VerticalDivider(
                color: Color(BLACK_COLOR),
                thickness: 1,
              ),
              Expanded(
                child: InkWell(
                  onTap: onPressedCheckOut,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "เช็คเอาท์",
                        style: SBFont.regular14.copyWith(
                          color: Color(BLACK_COLOR),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: SCDimens.dimen10),
                        child: Icon(
                          Icons.output,
                          color: Color(BLACK_COLOR),
                          size: SCDimens.dimen24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
