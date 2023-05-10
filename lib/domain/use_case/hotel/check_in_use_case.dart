import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constant/fail_code.dart';
import '../../../core/utils/print_util.dart';
import '../../../core/utils/shared_preferences_util.dart';
import '../../../data/models/failure/failure.dart';
import '../../../data/models/hotel/hotel_model.dart';

@injectable
class CheckInUseCase {
  @factoryParam
  final SharedPreferencesUtil _pref;

  CheckInUseCase(this._pref);

  Future<Either<bool, Failure>> execute({
    required String room,
    required String name,
    required int age,
  }) async {
    try {
      final String? dataHotel =
          _pref.getString(SharedPreferencesUtil.keyDataHotel);

      final String? dataKeyCard =
          _pref.getString(SharedPreferencesUtil.keyKeycard);

      final int? dataTotalCustomers =
          _pref.getInt(SharedPreferencesUtil.keyTotalCustomers);

      if (dataHotel != null &&
          dataKeyCard != null &&
          dataTotalCustomers != null) {
        dynamic hotelMap = jsonDecode(dataHotel);
        dynamic keyCardMap = jsonDecode(dataKeyCard);
        int totalCustomers = dataTotalCustomers;

        List<HotelModel> hotel = List<HotelModel>.from(
          hotelMap.map(
            (model) => HotelModel.fromJson(model),
          ),
        );

        List<KeycardModel> keyCard = List<KeycardModel>.from(
          keyCardMap.map(
            (model) => KeycardModel.fromJson(model),
          ),
        );

        final roomData = hotel.where((i) => i.room == room);
        int indexRoom = hotel.indexWhere((i) => i.room == room);
        final keyCardData = keyCard.where((i) => i.status == true);
        int indexkeyCard = keyCard.indexWhere((i) => i.status == true);

        if (roomData.length != 0) {
          if (roomData.first.status == true) {
            final HotelModel checkInroom = roomData.first;
            checkInroom.keycard = keyCardData.first.number;
            checkInroom.customer = CustomerModel(
              name: name,
              age: age,
            );
            checkInroom.status = false;
            hotel[indexRoom] = checkInroom;

            final KeycardModel checkInkeyCard = keyCardData.first;
            checkInkeyCard.status = false;
            keyCard[indexkeyCard] = checkInkeyCard;

            totalCustomers++;

            _pref.putString(
                SharedPreferencesUtil.keyDataHotel, jsonEncode(hotel));
            _pref.putString(
                SharedPreferencesUtil.keyKeycard, jsonEncode(keyCard));
            _pref.putInt(
                SharedPreferencesUtil.keyTotalCustomers, totalCustomers);

            print("save");
            return Left(true);
          } else {
            return Right(Failure(
              code: FailCode.FAIL_CHECK_IN_ROOM_BOOKED,
              message: roomData.first.customer?.name,
            ));
          }
        } else {
          return Right(Failure(code: FailCode.FAIL_CHECK_IN_ROOM_NOT_FOUND));
        }
      }
      return Right(Failure(code: FailCode.FAIL_CHECK_IN_ROOM_NOT_FOUND));
    } catch (err) {
      dPrint('CheckInUseCase Error : $err');
      return Right(Failure());
    }
  }
}
