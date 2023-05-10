part of 'hotel_bloc.dart';

class HotelStateData {
  final List<HotelModel> listHotel;
  final List<HotelModel> listCustomer;
  final int totalCustomers;
  final int totalRooms;

  HotelStateData({
    this.listHotel = const [],
    this.listCustomer = const [],
    this.totalCustomers = 0,
    this.totalRooms = 0,
  });

  HotelStateData copyWith({
    List<HotelModel>? newListHotel,
    List<HotelModel>? newListCustomer,
    int? newTotalCustomers,
    int? newTotalRooms,
  }) {
    return HotelStateData(
      listHotel: newListHotel ?? this.listHotel,
      listCustomer: newListCustomer ?? this.listCustomer,
      totalCustomers: newTotalCustomers ?? this.totalCustomers,
      totalRooms: newTotalRooms ?? this.totalRooms,
    );
  }
}

abstract class HotelState {
  final HotelStateData data;

  HotelState(this.data);
}

class InitialState extends HotelState {
  InitialState(super.data);
}

class LoadingState extends HotelState {
  LoadingState(super.data);
}

class CreateHotelSuccessState extends HotelState {
  CreateHotelSuccessState(super.data);
}

class CreateHotelFailState extends HotelState {
  CreateHotelFailState(super.data);
}

class RefreshHotelState extends HotelState {
  RefreshHotelState(super.data);
}

class GetHotelSuccessState extends HotelState {
  GetHotelSuccessState(super.data);
}

class GetHotelFailState extends HotelState {
  GetHotelFailState(super.data);
}

class CheckInSuccessState extends HotelState {
  CheckInSuccessState(super.data);
}

class CheckInFailState extends HotelState {
  CheckInFailState(super.data);
}

class CheckInRoomBookedState extends HotelState {
  final String? message;

  CheckInRoomBookedState(super.data, this.message);
}

class CheckInRoomNotFoundState extends HotelState {
  CheckInRoomNotFoundState(super.data);
}

class CheckOutSuccessState extends HotelState {
  CheckOutSuccessState(super.data);
}

class CheckOutFailState extends HotelState {
  CheckOutFailState(super.data);
}

class CheckOutRoomNotFoundState extends HotelState {
  CheckOutRoomNotFoundState(super.data);
}

class CheckOutRoomNotCheckInState extends HotelState {
  CheckOutRoomNotCheckInState(super.data);
}

class CheckOutKeyCardFailState extends HotelState {
  final String? message;
  CheckOutKeyCardFailState(super.data, this.message);
}

class CheckOutNameFailState extends HotelState {
  final String? message;
  CheckOutNameFailState(super.data, this.message);
}

class FilterRoomSuccessState extends HotelState {
  FilterRoomSuccessState(super.data);
}

class FilterRoomFailState extends HotelState {
  FilterRoomFailState(super.data);
}
