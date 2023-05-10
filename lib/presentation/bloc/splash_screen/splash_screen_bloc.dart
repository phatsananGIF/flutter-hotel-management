import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_case/common/check_data_hotel_use_case.dart';


part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

@injectable
class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final CheckDataHotelUseCase _checkDataHotelUseCase;

  SplashScreenBloc(
    this._checkDataHotelUseCase,
  ) : super(InitialState()) {
    on<CheckDataHotelEvent>(_onCheckDataHotel);
  }

  Future<FutureOr<void>> _onCheckDataHotel(
    CheckDataHotelEvent event,
    Emitter<SplashScreenState> emit,
  ) async {
    final result = await _checkDataHotelUseCase.execute();

    result.fold((status) {
      if (status) {
        emit(HaveDataHotelState());
      } else {
        emit(NoDataHotelState());
      }
    }, (fail) {
      emit(NoDataHotelState());
    });
  }
}
