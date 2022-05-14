import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class User extends Equatable {
  final String id;
  final String email;
  final String? userName;
  final String? familyName;
  final String? givenName;
  final String? nationality;
  final String? occupation;
  final double? age;
  final String dateCreated;
  final String dateUpdated;

  const User({
    required this.id,
    required this.email,
    this.userName,
    this.familyName,
    this.givenName,
    this.nationality,
    this.occupation,
    this.age,
    required this.dateCreated,
    required this.dateUpdated,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        userName,
        familyName,
        givenName,
        nationality,
        occupation,
        age,
        dateCreated,
        dateUpdated,
      ];
}
