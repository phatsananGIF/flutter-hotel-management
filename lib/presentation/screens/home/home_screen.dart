import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hotel_management/core/utils/navigator_util.dart';
import 'package:flutter_hotel_management/presentation/screens/check_out/check_out_screen.dart';

import '../../../core/di/injection_init.dart';
import '../../../core/styles/color.dart';
import '../../../core/styles/sarabun_font.dart';
import '../../../core/styles/screen_dimensions.dart';
import '../../../data/models/hotel/hotel_model.dart';
import '../../bloc/hotel/hotel_bloc.dart';
import '../../widgets/base_scaffold.dart';
import '../../widgets/dialog/dialog_error.dart';
import '../../widgets/dialog/dialog_room_detail.dart';
import '../../widgets/wg_list_builder.dart';
import '../check_in/check_in_screen.dart';
import 'widgets/home_bt.dart';
import 'widgets/home_summary_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HotelBloc _bloc;

  int selectedIndex = 0;
  List categories = ["ทั้งหมด", "ว่าง", "จอง"];

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
    selectedIndex = 0;
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
          hideBackButton: true,
          title: "My Hotel",
          titleColor: Color(WHITE_COLOR),
          backgroundColor: Color(BLACK_GRAY_COLOR),
          appBarBackgroundColor: Color(BLACK_GRAY_COLOR),
          body: Padding(
            padding: EdgeInsets.only(
              top: SCDimens.dimen10,
              right: SCDimens.dimen16,
              left: SCDimens.dimen16,
              bottom: SCDimens.screenVerticalPadding +
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: [
                HomeSummaryCard(
                  total: state.data.totalCustomers,
                ),
                SizedBox(height: SCDimens.dimen16),
                HomeBt(
                  onPressedCheckIn: () {
                    if (state.data.totalCustomers == state.data.totalRooms) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogError(
                            title: "โรงแรมเต็ม",
                            body: "ห้องถูกจองเต็มแล้ว",
                          );
                        },
                      );
                    } else {
                      NavigatorUtil.pushToPage(CheckInScreen()).then((value) {
                        _onRefresh;
                        refreshKey.currentState?.show();
                      });
                    }
                  },
                  onPressedCheckOut: () {
                    if (state.data.totalCustomers == 0) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogError(
                            title: "ไม่มีการจองห้อง",
                            body: "โรงแรมไม่มีผู้เข้าพัก",
                          );
                        },
                      );
                    } else {
                      NavigatorUtil.pushToPage(CheckOutScreen()).then((value) {
                        _onRefresh;
                        refreshKey.currentState?.show();
                      });
                    }
                  },
                ),
                SizedBox(height: SCDimens.dimen16),
                _category(),
                SizedBox(height: SCDimens.dimen16),
                Expanded(
                  child: RefreshIndicator(
                    key: refreshKey,
                    onRefresh: () => _onRefresh(context),
                    child: state is GetHotelSuccessState ||
                            state is GetHotelFailState
                        ? WgListBuilder<HotelModel>(
                            items: state.data.listHotel,
                            builder: (context, item) {
                              return _itemHotel(item);
                            },
                          )
                        : Container(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _itemHotel(HotelModel item) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogRoomDetail(
                  room: item.room,
                  status: item.status,
                  keycard: item.keycard,
                  name: item.customer?.name,
                  age: item.customer?.age.toString(),
                );
              },
            );
          },
          dense: true,
          minLeadingWidth: 0,
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity(vertical: -3),
          title: Row(
            children: [
              Icon(
                Icons.business,
                color: Color(WHITE_COLOR),
              ),
              SizedBox(width: SCDimens.dimen8),
              Text(
                item.room,
                style: SBFont.regular18.copyWith(
                  color: Color(WHITE_COLOR),
                ),
              ),
            ],
          ),
          subtitle: item.customer != null
              ? Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      color: Color(WHITE_COLOR),
                    ),
                    SizedBox(width: SCDimens.dimen8),
                    Text(
                      item.customer!.name,
                      style: SBFont.regular18.copyWith(
                        color: Color(WHITE_COLOR),
                      ),
                    ),
                  ],
                )
              : null,
          trailing: item.status
              ? Icon(
                  Icons.meeting_room,
                  color: Color(YELLOW_COLOR),
                  size: SCDimens.dimen24,
                )
              : Icon(
                  Icons.sensor_door,
                  color: Color(WHITE_GRAY_COLOR),
                  size: SCDimens.dimen24,
                ),
        ),
        Divider(
          color: Color(WHITE_COLOR),
          thickness: 0.5,
        ),
      ],
    );
  }

  _category() {
    return Container(
      height: SCDimens.dimen30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            if (index == 1) {
              _bloc.add(GetHotelEvent(status: true));
            } else if ((index == 2)) {
              _bloc.add(GetHotelEvent(status: false));
            } else {
              _bloc.add(GetHotelEvent());
            }
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: SCDimens.dimen8),
            padding: EdgeInsets.symmetric(horizontal: SCDimens.dimen8),
            decoration: BoxDecoration(
              color: index == selectedIndex
                  ? Colors.white.withOpacity(0.4)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: index == selectedIndex
                  ? null
                  : Border.all(color: Colors.white54),
            ),
            child: Text(
              categories[index],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
