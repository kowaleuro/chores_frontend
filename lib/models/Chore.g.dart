// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Chore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chore _$ChoreFromJson(Map<String, dynamic> json) => Chore(
      json['choreId'] as int?,
      json['choreName'] as String,
      $enumDecode(_$StatusEnumMap, json['status']),
      json['when'] == null ? null : DateTime.parse(json['when'] as String),
      json['userCloser'] == null
          ? null
          : User.fromJson(json['userCloser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChoreToJson(Chore instance) => <String, dynamic>{
      'choreId': instance.choreId,
      'choreName': instance.choreName,
      'status': _$StatusEnumMap[instance.status],
      'when': instance.when?.toIso8601String(),
      'userCloser': instance.userCloser?.toJson(),
    };

const _$StatusEnumMap = {
  Status.FINISHED: 'FINISHED',
  Status.OPEN: 'OPEN',
  Status.CANCELLED: 'CANCELLED',
};
