// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/data_source/remote/api_interceptors.dart' as _i3;
import '../../data/data_source/remote/api_provider.dart' as _i6;
import '../../domain/entities/app_flavor_data.dart' as _i5;
import '../../domain/use_case/common/check_data_hotel_use_case.dart' as _i7;
import '../../domain/use_case/hotel/check_in_use_case.dart' as _i8;
import '../../domain/use_case/hotel/check_out_use_case.dart' as _i9;
import '../../domain/use_case/hotel/create_hotel_use_case.dart' as _i10;
import '../../domain/use_case/hotel/get_hotel_use_case.dart' as _i11;
import '../../presentation/bloc/hotel/hotel_bloc.dart' as _i12;
import '../../presentation/bloc/splash_screen/splash_screen_bloc.dart' as _i13;
import '../utils/shared_preferences_util.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ApiInterceptors>(() => _i3.ApiInterceptors(
      get<_i4.SharedPreferencesUtil>(), get<_i5.AppFlavorData>()));
  gh.factory<_i6.ApiProvider>(
      () => _i6.ApiProvider(get<_i3.ApiInterceptors>()));
  gh.factory<_i7.CheckDataHotelUseCase>(
      () => _i7.CheckDataHotelUseCase(get<_i4.SharedPreferencesUtil>()));
  gh.factory<_i8.CheckInUseCase>(
      () => _i8.CheckInUseCase(get<_i4.SharedPreferencesUtil>()));
  gh.factory<_i9.CheckOutUseCase>(
      () => _i9.CheckOutUseCase(get<_i4.SharedPreferencesUtil>()));
  gh.factory<_i10.CreateHotelUseCase>(
      () => _i10.CreateHotelUseCase(get<_i4.SharedPreferencesUtil>()));
  gh.factory<_i11.GetHotelUseCase>(
      () => _i11.GetHotelUseCase(get<_i4.SharedPreferencesUtil>()));
  gh.factory<_i12.HotelBloc>(() => _i12.HotelBloc(
      get<_i10.CreateHotelUseCase>(),
      get<_i11.GetHotelUseCase>(),
      get<_i8.CheckInUseCase>(),
      get<_i9.CheckOutUseCase>(),
      get<_i4.SharedPreferencesUtil>()));
  gh.factory<_i13.SplashScreenBloc>(
      () => _i13.SplashScreenBloc(get<_i7.CheckDataHotelUseCase>()));
  return get;
}
