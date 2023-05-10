import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection_init.dart';
import '../../../core/styles/color.dart';
import '../../../core/styles/sarabun_font.dart';
import '../../../core/styles/screen_dimensions.dart';
import '../../../data/models/hotel/hotel_model.dart';
import '../../bloc/hotel/hotel_bloc.dart';
import '../../widgets/base_scaffold.dart';
import '../../widgets/wg_list_builder.dart';

class CustomerScreen extends StatefulWidget {
  CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late final HotelBloc _bloc;
  RangeValues _currentRangeValues = const RangeValues(1, 120);
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    _bloc = getIt.get<HotelBloc>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      refreshKey.currentState?.show();
    });
  }

  Future<bool> _onRefresh(BuildContext context) async {
    var bloc = _bloc..add(RefreshHotelEvent());
    var state = await bloc.stream.firstWhere(
        (state) => state is GetHotelSuccessState || state is GetHotelFailState);
    return state is GetHotelSuccessState || state is GetHotelFailState;
  }

  Future<void> _blocListener(BuildContext context, HotelState state) async {}

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
        return BaseScaffold(
          isLoading: state is LoadingState,
          title: "ลูกค้า",
          titleColor: Color(WHITE_COLOR),
          backgroundColor: Color(BLACK_GRAY_COLOR),
          appBarBackgroundColor: Color(BLACK_GRAY_COLOR),
          body: Container(
            child: Padding(
              padding: EdgeInsets.only(
                top: SCDimens.screenHorizontalPadding,
                right: SCDimens.screenHorizontalPadding,
                left: SCDimens.screenHorizontalPadding,
                bottom: SCDimens.screenVerticalPadding +
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(SCDimens.dimen6),
                    decoration: BoxDecoration(
                      color: Color(WHITE_COLOR),
                      borderRadius: BorderRadius.all(
                        Radius.circular(SCDimens.dimen10),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text("ช่วงอายุ", style: SBFont.regular14),
                        RangeSlider(
                          values: _currentRangeValues,
                          max: 120,
                          min: 1,
                          divisions: 120,
                          labels: RangeLabels(
                            _currentRangeValues.start.round().toString(),
                            _currentRangeValues.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues = values;
                            });
                            _bloc.add(GetHotelEvent(
                              ageStart: values.start.toInt(),
                              ageEnd: values.end.toInt(),
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SCDimens.dimen16),
                  Expanded(
                    child: RefreshIndicator(
                      key: refreshKey,
                      onRefresh: () => _onRefresh(context),
                      child: state is GetHotelSuccessState ||
                              state is GetHotelFailState
                          ? WgListBuilder<HotelModel>(
                              items: state.data.listCustomer,
                              builder: (context, item) {
                                return _itemCustomer(item);
                              },
                            )
                          : Container(),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _itemCustomer(HotelModel item) {
    return Column(
      children: [
        ListTile(
          dense: true,
          minLeadingWidth: 0,
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity(vertical: -3),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.person_outline,
                color: Color(WHITE_COLOR),
              ),
              SizedBox(width: SCDimens.dimen8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.customer!.name,
                    style: SBFont.regular18.copyWith(
                      color: Color(WHITE_COLOR),
                    ),
                  ),
                  Text(
                    "อายุ : ${item.customer!.age}",
                    style: SBFont.regular14.copyWith(
                      color: Color(WHITE_COLOR),
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: Text(
            "ห้อง : ${item.room}",
            style: SBFont.regular14.copyWith(
              color: Color(WHITE_COLOR),
            ),
          ),
        ),
        Divider(
          color: Color(WHITE_COLOR),
          thickness: 0.5,
        ),
      ],
    );
  }
}
