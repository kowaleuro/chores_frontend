import 'package:chores/models/status.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'Chore.g.dart';

@JsonSerializable(explicitToJson: true)
class Chore{
  Chore(this.choreId,this.choreName,this.status,this.when,this.userCloser);

  late int? choreId;
  late String choreName;
  late Status status;
  late DateTime? when;
  User? userCloser;

  factory Chore.fromJson(Map<String, dynamic> json) => _$ChoreFromJson(json);

  Map<String, dynamic> toJson() => _$ChoreToJson(this);

}