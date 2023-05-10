import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hotel_management/core/utils/navigator_util.dart';

import '../../../core/di/injection_init.dart';
import '../../../core/i18n/translations.g.dart';
import '../../../core/styles/sarabun_font.dart';
import '../../../core/styles/screen_dimensions.dart';
import '../../bloc/hotel/hotel_bloc.dart';
import '../../widgets/base_scaffold.dart';
import '../../widgets/dialog/dialog_error.dart';
import '../../widgets/wg_button.dart';
import '../../widgets/wg_text_form_field.dart';

class CheckInScreen extends StatefulWidget {
  CheckInScreen({Key? key}) : super(key: key);

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  late final HotelBloc _bloc;
  late final TextEditingController _room;
  late final TextEditingController _name;
  late final TextEditingController _age;

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
    _age = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  Future<void> _blocListener(BuildContext context, HotelState state) async {
    if (state is CheckInSuccessState) {
      NavigatorUtil.pop();
    } else if (state is CheckInRoomBookedState) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogError(
            title: "ไม่สามารถจองห้อง ${_room.text}",
            body:
                "ไม่สามารถจองห้อง ${_room.text} ให้กับ ${_name.text} ได้ ${state.message} เป็นผู้จองห้องพักในขณะนี้",
          );
        },
      );
    } else if (state is CheckInRoomNotFoundState) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogError(
            title: "ไม่สามารถจองห้อง ${_room.text}",
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
    _age.dispose();

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
          title: "เช็คอิน",
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
                              "กรุณาระบุอายุ",
                              style: SBFont.semiBold20,
                            ),
                          ),
                          WgTextField(
                            controller: _age,
                            hintText: "อายุ",
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
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
                              _age.text.isNotEmpty
                          ? () {
                              _bloc.add(
                                CheckInEvent(
                                  room: _room.text,
                                  name: _name.text,
                                  age: int.parse(_age.text),
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
