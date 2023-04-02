import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class UserProvider {
  final db = FirebaseFirestore.instance.collection('User');
  final user = User(name: 'Stephen', age: 3, sex: 'male', height: 7);
  var list = [];
  createuser() async {
    final docRef = db.withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: ((value, options) => value.toFirestore()));
    await docRef.add(user);
  }

  getUser()  {
    final ref = db.withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: ((value, options) => value.toFirestore()));
    final  docSnap =  ref.snapshots();
    return docSnap;
  }
  delete(index)async{
     final ref = db.withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: ((value, options) => value.toFirestore()));
    final  docSnap = await ref.doc(index).delete();
    return docSnap;
  }
}
