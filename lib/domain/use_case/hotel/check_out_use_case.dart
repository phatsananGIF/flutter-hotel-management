import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constant/fail_code.dart';
import '../../../core/utils/print_util.dart';
import '../../../core/utils/shared_preferences_util.dart';
import '../../../data/models/failure/failure.dart';
import '../../../data/models/hotel/hotel_model.dart';

@injectable
class CheckOutUseCase {
  @factoryParam
  final SharedPreferencesUtil _pref;

  CheckOutUseCase(this._pref);

  Future<Either<bool, Failure>> execute({
    required String room,
    required String name,
    required int keyCardNumber,
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
        final keyCardData = keyCard.where((i) => i.number == keyCardNumber);
        int indexkeyCard = keyCard.indexWhere((i) => i.number == keyCardNumber);

        if (roomData.length != 0) {
          if (roomData.first.status == false) {
            if (roomData.first.customer?.name != name) {
              print("customer name : ${roomData.first.customer}");
              return Right(Failure(
                code: FailCode.FAIL_CHECK_OUT_NAME_FAIL,
                message: roomData.first.customer?.name,
              ));
            } else if (roomData.first.keycard != keyCardNumber) {
              return Right(Failure(
                code: FailCode.FAIL_CHECK_OUT_KEY_CARD_FAIL,
                message: "${roomData.first.keycard}",
              ));
            } else {
              //check out

              final HotelModel checkOutroom = roomData.first;
              checkOutroom.keycard = null;
              checkOutroom.customer = null;
              checkOutroom.status = true;
              hotel[indexRoom] = checkOutroom;

              final KeycardModel checkOutkeyCard = keyCardData.first;
              checkOutkeyCard.status = true;
              keyCard[indexkeyCard] = checkOutkeyCard;

              totalCustomers--;

              _pref.putString(
                  SharedPreferencesUtil.keyDataHotel, jsonEncode(hotel));
              _pref.putString(
                  SharedPreferencesUtil.keyKeycard, jsonEncode(keyCard));
              _pref.putInt(
                  SharedPreferencesUtil.keyTotalCustomers, totalCustomers);

              print("save");
              return Left(true);
            }
          } else {
            return Right(
                Failure(code: FailCode.FAIL_CHECK_OUT_ROOM_NOT_CHECK_IN));
          }
        } else {
          return Right(Failure(code: FailCode.FAIL_CHECK_OUT_ROOM_NOT_FOUND));
        }
      }
      return Right(Failure(code: FailCode.FAIL_CHECK_OUT_ROOM_NOT_FOUND));
    } catch (err) {
      dPrint('CheckOutUseCase Error : $err');
      return Right(Failure());
    }
  }
}
