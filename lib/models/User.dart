class User {
  late final String name;
  late final String email;
  late final String password;

  User(this.name, this.email,this.password);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password
  };
}