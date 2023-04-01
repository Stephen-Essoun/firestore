import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final int age;
  final String sex;
  final double height;

  User(
      {required this.name,
      required this.age,
      required this.sex,
      required this.height});
  factory User.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? option,) {
    final data = snapshot.data();
    return User(
      name: data?['name'],
      age: data?['age'],
      sex: data?['sex'],
      height: data?['height'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'Name': name,
      'age': age,
      'sex': sex,
      'height': height,
    };
  }
}
