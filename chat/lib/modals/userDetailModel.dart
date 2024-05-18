import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userDetail {
  final String firstName;
  final String LastName;
  final String uid;
  final String password;
  final String email;
  userDetail(
      {required this.LastName,
      required this.firstName,
      required this.password,
      required this.uid,
      required this.email});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': LastName,
      'uid': uid,
      'password': password,
      'email': email,
    };
  }
}
