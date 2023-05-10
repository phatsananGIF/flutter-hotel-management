part of 'hotel_bloc.dart';

abstract class HotelEvent {}

class CreateHotelEvent extends HotelEvent {
  final int floor;
  final int room;

  CreateHotelEvent({required this.floor, required this.room});
}

class RefreshHotelEvent extends HotelEvent {}

class GetHotelEvent extends HotelEvent {
  final bool? status;
  final int? ageStart;
  final int? ageEnd;
  GetHotelEvent({this.status, this.ageStart, this.ageEnd});
}

class CheckInEvent extends HotelEvent {
  final String room;
  final String name;
  final int age;

  CheckInEvent({required this.room, required this.name, required this.age});
}

class CheckOutEvent extends HotelEvent {
  final String room;
  final String name;
  final int keyCard;

  CheckOutEvent(
      {required this.room, required this.name, required this.keyCard});
}
