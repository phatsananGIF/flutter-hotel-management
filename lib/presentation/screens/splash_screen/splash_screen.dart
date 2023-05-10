import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hotel_management/core/utils/print_util.dart';

import '../../../core/di/injection_init.dart';
import '../../../core/styles/color.dart';
import '../../../core/styles/screen_dimensions.dart';
import '../../../core/styles/sarabun_font.dart';
import '../../../core/utils/navigator_util.dart';
import '../../bloc/splash_screen/splash_screen_bloc.dart';
import '../../widgets/base_container.dart';
import '../create_hotel/create_hotel_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashScreenBloc _bloc;
  int count = 0;

  @override
  void initState() {
    super.initState();

    _bloc = getIt.get<SplashScreenBloc>();

    _bloc.add(CheckDataHotelEvent());
  }

  void _blocListener(BuildContext context, SplashScreenState state) {
    if (state is HaveDataHotelState) {
      checkCounter(() {
        NavigatorUtil.pushReplaceToPage(HomeScreen());
      });
    } else if (state is NoDataHotelState) {
      checkCounter(() {
        NavigatorUtil.pushReplaceToPage(CreateHotelScreen());
      });
    }
  }

  checkCounter(VoidCallback callback) {
    if (count < 3) {
      Future.delayed(Duration(seconds: 3 - count)).then((value) {
        callback();
      });
    } else {
      callback();
    }
  }

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashScreenBloc, SplashScreenState>(
      bloc: _bloc,
      listener: _blocListener,
      builder: (context, state) {
        return BaseContainer(
          isLoading: state is LoadingState,
          child: Container(
            padding: EdgeInsets.only(
              right: SCDimens.screenHorizontalPadding,
              left: SCDimens.screenHorizontalPadding,
              bottom: SCDimens.screenVerticalPadding +
                  MediaQuery.of(context).padding.bottom,
            ),
            color: Color(GREEN_GRAY_COLOR),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/hotel.png",
                ),
                Text(
                  "My Hotel",
                  style: SBFont.bold20.copyWith(
                    color: Color(WHITE_COLOR),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
