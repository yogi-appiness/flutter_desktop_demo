import 'package:mongo_dart/mongo_dart.dart';

/// User data model with the necessary fields
class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    this.email,
    this.phoneNumber,
  });

  /// Unique id for user
  final ObjectId id;

  /// Full name of user
  final String name;

  /// Username of user
  final String username;

  /// Password
  final String password;

  /// Email
  final String? email;

  /// User's phone number
  final String? phoneNumber;

  /// Copy with function
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

  /// Convert map into user object
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        phoneNumber: json["phone_number"],
      );

  /// Convert user object to map
  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "password": password,
        "email": email,
        "phone_number": phoneNumber,
      };
}
