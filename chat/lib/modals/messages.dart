import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Messages {
  final String reciverId;
  final String uuid;
  final String senderId;
  final String message;
  final Timestamp timestamp;
  final int thumbsUp;
  final int thumbsDawn;
  Messages({
    required this.uuid,
    required this.reciverId,
    required this.message,
    required this.senderId,
    required this.timestamp,
    required this.thumbsDawn,
    required this.thumbsUp,
  });

  Map<String, dynamic> toMap() {
    return {
      'reciverId': reciverId,
      'message': message,
      'senderId': senderId,
      'timestamp': timestamp,
      'thumbsUp': thumbsUp,
      'thumbsDawn': thumbsDawn,
      'uuid': uuid,
    };
  }
}
