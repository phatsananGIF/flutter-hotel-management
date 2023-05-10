import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection_init.dart';
import '../../../core/i18n/translations.g.dart';
import '../../../core/styles/sarabun_font.dart';
import '../../../core/styles/screen_dimensions.dart';
import '../../../core/utils/navigator_util.dart';
import '../../bloc/hotel/hotel_bloc.dart';
import '../../widgets/base_scaffold.dart';
import '../../widgets/dialog/dialog_error.dart';
import '../../widgets/wg_button.dart';
import '../../widgets/wg_text_form_field.dart';

class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late final HotelBloc _bloc;
  late final TextEditingController _room;
  late final TextEditingController _name;
  late final TextEditingController _keyCard;

  @override
  void initState() {
    super.initState();

    _bloc = getIt.get<HotelBloc>();

    _room = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _name = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _keyCard = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  Future<void> _blocListener(BuildContext context, HotelState state) async {
    if (state is CheckOutSuccessState) {
      NavigatorUtil.pop();
    } else if (state is CheckOutNameFailState) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogError(
            title: "ไม่สามารถเช็คเอาท์ห้อง ${_room.text}",
            body:
                "${_name.text} ไม่สามารถเช็คเอาท์ห้อง ${_room.text} ต้องเป็น ${state.message} เท่านั้นที่สามารถเช็คเอาท์ได้",
          );
        },
      );
    } else if (state is CheckOutKeyCardFailState) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogError(
            title: "ไม่สามารถเช็คเอาท์ห้อง ${_room.text}",
            body:
                "คีย์การ์ดหมายเลข ${_keyCard.text} ไม่ถูก ต้องเป็นคีย์การ์ดหมายเลข ${state.message}",
          );
        },
      );
    } else if (state is CheckOutRoomNotCheckInState) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogError(
            title: "ไม่สามารถเช็คเอาท์ห้อง ${_room.text}",
            body: "ห้องพัก ${_room.text} ยังไม่ได้เช็คอิน",
          );
        },
      );
    } else if (state is CheckOutRoomNotFoundState) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogError(
            title: "ไม่สามารถเช็คเอาท์ห้อง ${_room.text}",
            body: "ไม่พบห้องพัก ${_room.text} ในโรงแรม",
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _bloc.close();

    _room.dispose();
    _name.dispose();
    _keyCard.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return BlocConsumer<HotelBloc, HotelState>(
      bloc: _bloc,
      listener: _blocListener,
      builder: (context, state) {
        return BaseScaffold(
          isLoading: state is LoadingState,
          title: "เช็คเอาท์",
          body: Container(
            child: Padding(
              padding: EdgeInsets.only(
                top: SCDimens.dimen20 + MediaQuery.of(context).padding.top,
                right: SCDimens.screenHorizontalPadding,
                left: SCDimens.screenHorizontalPadding,
                bottom: SCDimens.screenVerticalPadding +
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: SCDimens.dimen8,
                            ),
                            child: Text(
                              "กรุณาระบุเลขห้อง",
                              style: SBFont.semiBold20,
                            ),
                          ),
                          WgTextField(
                            controller: _room,
                            hintText: "เลขห้อง",
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              FilteringTextInputFormatter.allow(
                                RegExp("^(([1-9][0-9]{0,8}))(\.[0-9]{0,2})?"),
                              )
                            ],
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: SCDimens.dimen16),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: SCDimens.dimen8,
                            ),
                            child: Text(
                              "กรุณาระบุชื่อ",
                              style: SBFont.semiBold20,
                            ),
                          ),
                          WgTextField(
                            controller: _name,
                            hintText: "ชื่อ",
                          ),
                          SizedBox(height: SCDimens.dimen16),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: SCDimens.dimen8,
                            ),
                            child: Text(
                              "กรุณาระบุคีย์การ์ด",
                              style: SBFont.semiBold20,
                            ),
                          ),
                          WgTextField(
                            controller: _keyCard,
                            hintText: "คีย์การ์ด",
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                              FilteringTextInputFormatter.allow(
                                RegExp("^(([1-9][0-9]{0,8}))(\.[0-9]{0,2})?"),
                              )
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !keyboardIsOpen,
                    child: WgButton(
                      text: AppLocalizations.global.ok,
                      onPressed: _room.text.isNotEmpty &&
                              _name.text.isNotEmpty &&
                              _keyCard.text.isNotEmpty
                          ? () {
                              _bloc.add(
                                CheckOutEvent(
                                  room: _room.text,
                                  name: _name.text,
                                  keyCard: int.parse(_keyCard.text),
                                ),
                              );
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
