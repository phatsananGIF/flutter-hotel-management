import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constant/fail_code.dart';
import '../../../core/utils/shared_preferences_util.dart';
import '../../../data/models/hotel/hotel_model.dart';
import '../../../domain/use_case/hotel/check_in_use_case.dart';
import '../../../domain/use_case/hotel/check_out_use_case.dart';
import '../../../domain/use_case/hotel/create_hotel_use_case.dart';
import '../../../domain/use_case/hotel/get_hotel_use_case.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

@injectable
class HotelBloc extends Bloc<HotelEvent, HotelState> {
  CreateHotelUseCase _createHotelUseCase;
  GetHotelUseCase _getHotelUseCase;
  CheckInUseCase _checkInUseCase;
  CheckOutUseCase _checkOutUseCase;

  @factoryParam
  final SharedPreferencesUtil _pref;

  HotelBloc(
    this._createHotelUseCase,
    this._getHotelUseCase,
    this._checkInUseCase,
    this._checkOutUseCase,
    this._pref,
  ) : super(InitialState(HotelStateData())) {
    on<CreateHotelEvent>(_onCreateHotel);
    on<RefreshHotelEvent>(_onRefreshHotel);
    on<GetHotelEvent>(_onGetHotel);
    on<CheckInEvent>(_onCheckIn);
    on<CheckOutEvent>(_onCheckOut);
  }

  FutureOr<void> _onCreateHotel(
    CreateHotelEvent event,
    Emitter<HotelState> emit,
  ) async {
    emit(LoadingState(state.data));

    final result =
        await _createHotelUseCase.execute(floor: event.floor, room: event.room);

    result.fold((hotel) {
      emit(CreateHotelSuccessState(state.data));
    }, (fail) {
      emit(CreateHotelFailState(state.data));
    });
  }

  FutureOr<void> _onRefreshHotel(
    RefreshHotelEvent event,
    Emitter<HotelState> emit,
  ) {
    emit(RefreshHotelState(state.data.copyWith(
      newListHotel: [],
      newListCustomer: [],
    )));

    add(GetHotelEvent());
  }

  Future<FutureOr<void>> _onGetHotel(
    GetHotelEvent event,
    Emitter<HotelState> emit,
  ) async {
    emit(LoadingState(state.data));

    final result = await this._getHotelUseCase.execute();

    result.fold((data) {
      final List<HotelModel> dataCustomer =
          data.where((i) => i.customer != null).toList();
      int? totalCustomers =
          _pref.getInt(SharedPreferencesUtil.keyTotalCustomers);
      List<HotelModel> hotel = data;
      List<HotelModel> customer = dataCustomer;

      if (event.status != null) {
        hotel = data.where((i) => i.status == event.status).toList();
      }

      if (event.ageStart != null && event.ageEnd != null) {
        customer = dataCustomer.where((i) {
          if (i.customer != null) {
            return i.customer!.age >= event.ageStart! &&
                i.customer!.age <= event.ageEnd!;
          } else {
            return true;
          }
        }).toList();
      }

      emit(GetHotelSuccessState(state.data.copyWith(
        newListHotel: hotel,
        newListCustomer: customer,
        newTotalCustomers: totalCustomers,
        newTotalRooms: data.length,
      )));
    }, (fail) {
      emit(GetHotelFailState(state.data));
    });
  }

  Future<FutureOr<void>> _onCheckIn(
    CheckInEvent event,
    Emitter<HotelState> emit,
  ) async {
    emit(LoadingState(state.data));

    final result = await _checkInUseCase.execute(
      room: event.room,
      name: event.name,
      age: event.age,
    );

    result.fold((checkIn) {
      emit(CheckInSuccessState(state.data));
    }, (fail) {
      if (fail.code == FailCode.FAIL_CHECK_IN_ROOM_BOOKED) {
        emit(CheckInRoomBookedState(state.data, fail.message));
      } else if (fail.code == FailCode.FAIL_CHECK_IN_ROOM_NOT_FOUND) {
        emit(CheckInRoomNotFoundState(state.data));
      } else {
        emit(CheckInFailState(state.data));
      }
    });
  }

  Future<FutureOr<void>> _onCheckOut(
    CheckOutEvent event,
    Emitter<HotelState> emit,
  ) async {
    emit(LoadingState(state.data));

    final result = await _checkOutUseCase.execute(
      room: event.room,
      name: event.name,
      keyCardNumber: event.keyCard,
    );

    result.fold((checkOut) {
      emit(CheckOutSuccessState(state.data));
    }, (fail) {
      if (fail.code == FailCode.FAIL_CHECK_OUT_NAME_FAIL) {
        emit(CheckOutNameFailState(state.data, fail.message));
      } else if (fail.code == FailCode.FAIL_CHECK_OUT_KEY_CARD_FAIL) {
        emit(CheckOutKeyCardFailState(state.data, fail.message));
      } else if (fail.code == FailCode.FAIL_CHECK_OUT_ROOM_NOT_CHECK_IN) {
        emit(CheckOutRoomNotCheckInState(state.data));
      } else if (fail.code == FailCode.FAIL_CHECK_OUT_ROOM_NOT_FOUND) {
        emit(CheckOutRoomNotFoundState(state.data));
      } else {
        emit(CheckOutFailState(state.data));
      }
    });
  }
}
