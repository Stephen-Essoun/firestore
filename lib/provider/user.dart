import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class UserProvider {
  final db = FirebaseFirestore.instance.collection('User');
  createuser(User user) async {
    final docRef = db.withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: ((value, options) => value.toFirestore()));
    await docRef.add(user);
  }
  getUser()async{
    final ref = db.withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: ((value, options) => value.toFirestore()));
      final docSnap = await ref.get();
      final user = docSnap.docs.map((e) => e.data());
      if(user.isNotEmpty){
        log('$user');
      }else{log('empty');}
  }
}
