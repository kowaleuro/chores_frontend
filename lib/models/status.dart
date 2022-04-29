import 'package:json_annotation/json_annotation.dart';

enum Status{

  @JsonValue('FINISHED')
  FINISHED,

  @JsonValue('OPEN')
  OPEN,

  @JsonValue('CANCELLED')
  CANCELLED
}