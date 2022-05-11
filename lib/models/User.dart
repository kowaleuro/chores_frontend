import 'package:json_annotation/json_annotation.dart';


part 'User.g.dart';

@JsonSerializable()
class User {
  late final String nickname;
  late final String email;
  String? password;

  User(this.nickname, this.email);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}