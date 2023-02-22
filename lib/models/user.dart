import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String address;
  final String email;
  final String uid;

  User(
      {required this.name,
      required this.address,
      required this.email,
      required this.uid});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'email': email,
      'uid': uid,
    };
  }

  static User fromSnap(DocumentSnapshot snap) {
    var map = snap.data() as Map<String, dynamic>;

    return User(
      name: map['name'],
      address: map['address'],
      email: map['email'],
      uid: map['uid'],
    );
  }
}
