import 'package:flutter/material.dart';
import 'package:flutter_hotel_management/core/styles/sarabun_font.dart';

import '../../../../core/i18n/translations.g.dart';
import '../../../core/styles/color.dart';

class DialogRoomDetail extends StatefulWidget {
  final String room;
  final bool status;
  final int? keycard;
  final String? name;
  final String? age;

  DialogRoomDetail({
    Key? key,
    required this.room,
    required this.status,
    this.keycard,
    this.name,
    this.age,
  }) : super(key: key);

  @override
  _DialogRoomDetailState createState() => _DialogRoomDetailState();
}

class _DialogRoomDetailState extends State<DialogRoomDetail> {
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
                  "ห้อง ${widget.room}",
                  style: SBFont.bold18.copyWith(
                    color: Color(SECOND900_COLOR),
                  ),
                ),
                SizedBox(
                  height: 14.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "สถานะห้อง : ",
                        style: SBFont.regular16.copyWith(
                          color: Color(GRAY_COLOR),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.status ? "ว่าง" : "จอง",
                        style: SBFont.regular16.copyWith(
                          color: Color(GRAY_COLOR),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                if (widget.keycard != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "คีย์การ์ด : ",
                          style: SBFont.regular16.copyWith(
                            color: Color(GRAY_COLOR),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${widget.keycard}",
                          style: SBFont.regular16.copyWith(
                            color: Color(GRAY_COLOR),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                if (widget.name != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ชื่อ : ",
                          style: SBFont.regular16.copyWith(
                            color: Color(GRAY_COLOR),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${widget.name}",
                          style: SBFont.regular16.copyWith(
                            color: Color(GRAY_COLOR),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                if (widget.age != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "อายุ : ",
                          style: SBFont.regular16.copyWith(
                            color: Color(GRAY_COLOR),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${widget.age}",
                          style: SBFont.regular16.copyWith(
                            color: Color(GRAY_COLOR),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
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
