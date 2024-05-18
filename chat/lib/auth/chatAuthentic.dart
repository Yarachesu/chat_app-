import 'package:chat/auth/authentication.dart';
import 'package:chat/modals/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class chatServices {
  final FirebaseAuth _chatAuth = FirebaseAuth.instance;
  final FirebaseFirestore _chatFirestore = FirebaseFirestore.instance;

  //get the contact name

  Stream<List<Map<String, dynamic>>> getContactName() {
    return _chatFirestore.collection('chatAppUser').snapshots().map((snapshot) {
      return snapshot.docs.map((snap) {
        final user = snap.data();
        return user;
      }).toList();
    });
  }

  //get comment message

  Stream<QuerySnapshot> getComments({
    required String reciverId,
  }) {
    String senderId = authServices().getCurrentUser()!.uid;
    List<String> chatRoomId = [reciverId, senderId];
    chatRoomId.sort();
    String chatId = chatRoomId.join('_');
    return _chatFirestore
        .collection('char_room')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  //put comment message

  Future<void> putComments({
    required String reciverId,
    required String messages,
  }) async {
    String msUid = Uuid().v1();
    Timestamp timestamp = Timestamp.now();
    Messages message = Messages(
      uuid: msUid,
      thumbsDawn: 0,
      thumbsUp: 0,
      senderId: _chatAuth.currentUser!.uid,
      reciverId: reciverId,
      message: messages,
      timestamp: timestamp,
    );
    String senderId = _chatAuth.currentUser!.uid;
    List<String> chatRoomId = [reciverId, senderId];
    chatRoomId.sort();
    String chatId = chatRoomId.join('_');

    await _chatFirestore
        .collection('char_room')
        .doc(chatId)
        .collection('messages')
        .doc(msUid)
        .set(message.toMap());
  }

  //
}
