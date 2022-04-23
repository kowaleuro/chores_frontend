// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      json['placeName'] as String,
      json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      json['placeImageLink'] as String?,
      json['placeId'] as int?,
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'placeId': instance.placeId,
      'placeName': instance.placeName,
      'created': instance.created?.toIso8601String(),
      'placeImageLink': instance.placeImageLink,
    };
