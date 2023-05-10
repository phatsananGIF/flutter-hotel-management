import 'package:flutter_hotel_management/domain/entities/hotel/keycard_data.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/customer/customer_data.dart';

part 'hotel_model.g.dart';

@JsonSerializable()
class HotelModel {
  String room;
  int? keycard;
  CustomerModel? customer;
  bool status;

  HotelModel({
    required this.room,
    this.keycard,
    required this.customer,
    required this.status,
  });

  factory HotelModel.fromJson(json) => _$HotelModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelModelToJson(this);
}

@JsonSerializable()
class CustomerModel extends CustomerData {
  CustomerModel({
    required super.name,
    required super.age,
  });

  factory CustomerModel.fromJson(json) => _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}

@JsonSerializable()
class KeycardModel extends KeycardData {
  KeycardModel({
    required super.number,
    required super.status,
  });

  factory KeycardModel.fromJson(json) => _$KeycardModelFromJson(json);

  Map<String, dynamic> toJson() => _$KeycardModelToJson(this);
}
