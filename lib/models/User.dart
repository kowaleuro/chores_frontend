class User {
  late final String nickname;
  late final String email;
  final String? password;

  User(this.nickname, this.email,this.password);

  User.fromJson(Map<String, dynamic> json, this.password)
      : nickname = json['nickname'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
    'nickname': nickname,
    'email': email,
    'password': password
  };
}