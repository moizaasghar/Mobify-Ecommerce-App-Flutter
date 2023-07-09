// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'order.dart';

class User {
  final String name;
  final String email;
  final String phone;
  final String password;
  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  User copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(name: $name, email: $email, phone: $phone, password: $password)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.phone == phone &&
      other.password == password;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      password.hashCode;
  }
}

class UserModel {
  static List<User> users = [];

  static void add(User user) {
    users.add(user);
  }

  static void remove(User user) {
    users.remove(user);
  }

  static void update(User user) {
    final index = users.indexWhere((element) => element.email == user.email);
    if (index >= 0) {
      users[index] = user;
    }
  }

  static User? getByEmail(String email) {
    try {
      return users.firstWhere((element) => element.email == email);
    } catch (e) {
      return null;
    }
  }
}

