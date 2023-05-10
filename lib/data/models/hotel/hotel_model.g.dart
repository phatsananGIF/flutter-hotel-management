// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelModel _$HotelModelFromJson(Map<String, dynamic> json) => HotelModel(
      room: json['room'] as String,
      keycard: json['keycard'] as int?,
      customer: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer']),
      status: json['status'] as bool,
    );

Map<String, dynamic> _$HotelModelToJson(HotelModel instance) =>
    <String, dynamic>{
      'room': instance.room,
      'keycard': instance.keycard,
      'customer': instance.customer,
      'status': instance.status,
    };

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      name: json['name'] as String,
      age: json['age'] as int,
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
    };

KeycardModel _$KeycardModelFromJson(Map<String, dynamic> json) => KeycardModel(
      number: json['number'] as int,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$KeycardModelToJson(KeycardModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'status': instance.status,
    };
