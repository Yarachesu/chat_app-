import 'package:chat/modals/userDetailModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class authServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser!;
  }

//signin

  Future<String> signInUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = 'unknown error';
    try {
      UserCredential _cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return res = 'success';
    } catch (e) {
      res = e.toString();
      return res;
    }
  }

//signup

  Future<String> signUpUser({
    required String firstname,
    required String Lastname,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    String res = 'unknown Error';
    try {
      if (password == confirmPassword) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _firestore
            .collection('chatAppUser')
            .doc(_auth.currentUser!.uid)
            .set({
          'firstName': firstname,
          'lastName': Lastname,
          'email': email,
          'password': password,
          'uid': _auth.currentUser!.uid,
        });
        res = 'success';
      } else {
        res = 'password doesnt match';
      }
      return res;
    } catch (e) {
      return res = e.toString();
    }
  }

  //sign out

  Future<void> logOutUser() async {
    await _auth.signOut();
  }

  //get user details

  Stream<List<Map<String, dynamic>>> getContactDetails() {
    return FirebaseFirestore.instance
        .collection('chatAppUser')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((snap) {
        final user = snap.data();
        return user;
      }).toList();
    });
  }

//store user details in modals

  Future<Map<String, dynamic>> userMap() async {
    Stream<List<Map<String, dynamic>>> data = getContactDetails();

    List<Map<String, dynamic>> Data = await data.first;
    List<Map<String, dynamic>> allData = Data.where((element) {
      return element['uid'] == authServices().getCurrentUser()!.uid;
    }).toList();

    if (allData.isNotEmpty) {
      userDetail detail = userDetail(
          LastName: allData[0]['lastName'],
          firstName: allData[0]['firstName'],
          password: allData[0]['password'],
          uid: allData[0]['uid'],
          email: allData[0]['email']);
      return detail.toMap();
    } else {
      return {};
    }
  }

  //update the name of user

  Future<String> updateName({
    required String uid,
    required String firstName,
    required String lastName,
  }) async {
    String y = 'upExpected';
    try {
      await _firestore
          .collection('chatAppUser')
          .doc(uid)
          .update({'firstName': firstName, 'lastName': lastName});
      y = 'success';
      return y;
    } catch (e) {
      y = e.toString();
      return y;
    }
  }

  Future<String> updatePassword({
    required String uid,
    required String Newpassword,
  }) async {
    String y = 'upExpected';
    try {
      await _firestore.collection('chatAppUser').doc(uid).update({
        'password': Newpassword,
      });
      y = 'success';
      return y;
    } catch (e) {
      y = e.toString();
      return y;
    }
  }
}
