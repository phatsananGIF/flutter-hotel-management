import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/print_util.dart';
import '../../../core/utils/shared_preferences_util.dart';
import '../../../data/models/failure/failure.dart';
import '../../../data/models/hotel/hotel_model.dart';

@injectable
class CheckDataHotelUseCase {
  @factoryParam
  final SharedPreferencesUtil _pref;

  CheckDataHotelUseCase(this._pref);

  Future<Either<bool, Failure>> execute() async {
    try {
      var _dataHotel = _pref.getString(SharedPreferencesUtil.keyDataHotel);

      if (_dataHotel == null) {
        return Left(false);
      } else {
        return Left(true);
      }
    } catch (err) {
      dPrint("CheckDataHotelUseCase Error : $err");
      return Right(Failure());
    }
  }
}
