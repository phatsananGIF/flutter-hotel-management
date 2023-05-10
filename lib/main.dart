import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/config/flavor/flavor_manager.dart';
import 'core/di/injection_init.dart';
import 'core/utils/navigator_util.dart';
import 'core/utils/shared_preferences_util.dart';
import 'domain/entities/app_flavor_data.dart';
import 'presentation/bloc/splash_screen/splash_screen_bloc.dart';
import 'presentation/screens/splash_screen/splash_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  HttpOverrides.global = new MyHttpOverrides();

  //#region Register get it manual
  configureDependencies();
  AppFlavorData setting = await FlavorManager.getFlavorSetting();
  SharedPreferencesUtil sharedPreferencesUtil =
      await SharedPreferencesUtil.getInstance();

  getIt.registerSingleton<AppFlavorData>(setting);
  getIt.registerSingleton<SharedPreferencesUtil>(sharedPreferencesUtil);
  //#endregion

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext myAppContext) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt.get<SplashScreenBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: Size(360, 768),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('th'),
              const Locale('en'),
            ],
            locale: const Locale('th'),
            navigatorKey: NavigatorUtil.navigate,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
