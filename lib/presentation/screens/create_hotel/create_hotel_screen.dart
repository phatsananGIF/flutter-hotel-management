import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection_init.dart';
import '../../../core/i18n/translations.g.dart';
import '../../../core/styles/sarabun_font.dart';
import '../../../core/styles/screen_dimensions.dart';
import '../../../core/utils/navigator_util.dart';
import '../../bloc/hotel/hotel_bloc.dart';
import '../../widgets/base_container.dart';
import '../../widgets/wg_button.dart';
import '../../widgets/wg_text_form_field.dart';
import '../home/home_screen.dart';

class CreateHotelScreen extends StatefulWidget {
  CreateHotelScreen({Key? key}) : super(key: key);

  @override
  State<CreateHotelScreen> createState() => _CreateHotelScreenState();
}

class _CreateHotelScreenState extends State<CreateHotelScreen> {
  late final HotelBloc _bloc;
  final TextEditingController _floor = TextEditingController();
  final TextEditingController _room = TextEditingController();

  @override
  void initState() {
    super.initState();

    _bloc = getIt.get<HotelBloc>();
  }

  Future<void> _blocListener(BuildContext context, HotelState state) async {
    if (state is CreateHotelSuccessState) {
      NavigatorUtil.pushReplaceToPage(HomeScreen());
    }
  }

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HotelBloc, HotelState>(
      bloc: _bloc,
      listener: _blocListener,
      builder: (context, state) {
        return BaseContainer(
          isLoading: state is LoadingState,
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: SCDimens.dimen8,
                        ),
                        child: Text(
                          "สร้างโรงแรม",
                          style: SBFont.semiBold20,
                        ),
                      ),
                      SizedBox(height: SCDimens.dimen24),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "จำนวนชั้น",
                              style: SBFont.regular16,
                            ),
                          ),
                          Expanded(
                            child: WgTextField(
                              controller: _floor,
                              hintText: "x",
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.allow(
                                  RegExp("^(([1-9][0-9]{0,8}))(\.[0-9]{0,2})?"),
                                )
                              ],
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SCDimens.dimen10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "จำนวนห้องต่อชั้น",
                              style: SBFont.regular16,
                            ),
                          ),
                          Expanded(
                            child: WgTextField(
                              controller: _room,
                              hintText: "xx",
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                                FilteringTextInputFormatter.allow(
                                  RegExp("^(([1-9][0-9]{0,8}))(\.[0-9]{0,2})?"),
                                )
                              ],
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SCDimens.dimen10),
                    ],
                  ),
                ),
                WgButton(
                    text: AppLocalizations.global.ok,
                    onPressed: () {
                      if (_floor.text.isNotEmpty && _room.text.isNotEmpty) {
                        _bloc.add(
                          CreateHotelEvent(
                            floor: int.parse(_floor.text),
                            room: int.parse(_room.text),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
