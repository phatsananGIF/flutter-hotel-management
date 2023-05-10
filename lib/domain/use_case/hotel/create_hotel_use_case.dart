import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/print_util.dart';
import '../../../core/utils/shared_preferences_util.dart';
import '../../../data/models/failure/failure.dart';
import '../../../data/models/hotel/hotel_model.dart';

@injectable
class CreateHotelUseCase {
  @factoryParam
  final SharedPreferencesUtil _pref;

  CreateHotelUseCase(this._pref);

  Future<Either<bool, Failure>> execute({
    required int floor,
    required int room,
  }) async {
    try {
      final List<HotelModel> hotel = [];
      final List<KeycardModel> keycard = [];
      for (var f = 1; f <= floor; f++) {
        for (var r = 1; r <= room; r++) {
          final String roomNumber = "$f${r.toString().padLeft(2, '0')}";
          hotel.add(
            HotelModel(
              room: roomNumber,
              customer: null,
              status: true,
            ),
          );
          keycard.add(
            KeycardModel(
              number: r,
              status: true,
            ),
          );
        }
      }

      _pref.putString(SharedPreferencesUtil.keyDataHotel, jsonEncode(hotel));
      _pref.putString(SharedPreferencesUtil.keyKeycard, jsonEncode(keycard));
      _pref.putInt(SharedPreferencesUtil.keyTotalCustomers, 0);

      return Left(true);
    } catch (err) {
      dPrint('CreateHotelUseCase Error : $err');
      return Right(Failure());
    }
  }
}
