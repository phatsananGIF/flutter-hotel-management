import 'package:flutter/material.dart';
import 'package:flutter_hotel_management/core/styles/sarabun_font.dart';

import '../../../../core/i18n/translations.g.dart';
import '../../../core/styles/color.dart';

class DialogError extends StatefulWidget {
  final String? title;
  final String? body;

  DialogError({
    Key? key,
    this.title,
    this.body,
  }) : super(key: key);

  @override
  _DialogErrorState createState() => _DialogErrorState();
}

class _DialogErrorState extends State<DialogError> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Text(
                  "${widget.title ?? "เกิดข้อผิดพลาด"}",
                  style: SBFont.bold18.copyWith(
                    color: Color(SECOND900_COLOR),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "${widget.body ?? "ระบบไม่สามารถทำรายการได้ในขณะนี้ กรุณาลองอีกครั้งในภายหลัง"}",
                  style: SBFont.regular16.copyWith(
                    color: Color(GRAY_COLOR),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color(PRIMARY_COLOR)),
                  foregroundColor:
                      MaterialStateProperty.all(Color(WHITE_COLOR)),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: Text(
                  AppLocalizations.global.ok,
                  style: SBFont.medium16.copyWith(
                    color: Color(WHITE_COLOR),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
