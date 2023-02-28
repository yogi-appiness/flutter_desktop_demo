import 'package:mongo_dart/mongo_dart.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    this.email,
    this.phoneNumber,
  });

  final ObjectId id;
  final String name;
  final String username;
  final String password;
  final String? email;
  final String? phoneNumber;

  User copyWith({
    ObjectId? id,
    String? name,
    String? username,
    String? password,
    String? email,
    String? phoneNumber,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        password: password ?? this.password,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "password": password,
        "email": email,
        "phone_number": phoneNumber,
      };
}
