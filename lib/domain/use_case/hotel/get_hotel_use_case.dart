import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/print_util.dart';
import '../../../core/utils/shared_preferences_util.dart';
import '../../../data/models/failure/failure.dart';
import '../../../data/models/hotel/hotel_model.dart';

@injectable
class GetHotelUseCase {
  @factoryParam
  final SharedPreferencesUtil _pref;

  GetHotelUseCase(this._pref);

  Future<Either<List<HotelModel>, Failure>> execute() async {
    try {
      final String? dataHotel =
          _pref.getString(SharedPreferencesUtil.keyDataHotel);

      if (dataHotel != null) {
        dynamic hotelMap = jsonDecode(dataHotel);

        List<HotelModel> hotel = List<HotelModel>.from(
          hotelMap.map(
            (model) => HotelModel.fromJson(model),
          ),
        );

        return Left(hotel);
      } else {
        return Left([]);
      }
    } catch (err) {
      dPrint('GetHotelUseCase Error : $err');
      return Right(Failure());
    }
  }
}
