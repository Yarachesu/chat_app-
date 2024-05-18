import 'dart:js_interop';

import 'package:chat/auth/authentication.dart';
import 'package:chat/auth/chatAuthentic.dart';
import 'package:chat/services/blocs/bloc/comment_bloc.dart';
import 'package:chat/utils/theme.dart';
import 'package:chat/widgets/chatbuble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class chatWith extends StatelessWidget {
  final String fullName;
  final String reciverId;
  chatWith({
    super.key,
    required this.reciverId,
    required this.fullName,
  });
  chatServices service = chatServices();
  TextEditingController _chatcont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primeryColor,
      appBar: AppBar(
        title: Text(fullName),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildGetMessages(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildGetMessages() {
    return StreamBuilder(
      stream: service.getComments(
        reciverId: reciverId,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('error!'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map((snap) => _buildMessage(snap, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessage(DocumentSnapshot doc, BuildContext context) {
    String senderId = (doc.data() as Map<String, dynamic>)['senderId'];
    bool iscurrentUser = senderId == authServices().getCurrentUser()!.uid;
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    String reciverId = data['reciverId'];

    List<String> chatRoomId = [reciverId, senderId];
    chatRoomId.sort();
    String chatId = chatRoomId.join('_');
    return Column(
      crossAxisAlignment:
          iscurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        bubble(
          iscurrentUser: iscurrentUser,
          message: data['message'],
          uuid: data['uuid'],
          chatId: chatId,
        ),
        Row(
          mainAxisAlignment:
              iscurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade200,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      String senderId = data['senderId'];
                      String reciverId = data['reciverId'];

                      List<String> chatRoomId = [reciverId, senderId];
                      chatRoomId.sort();
                      String chatId = chatRoomId.join('_');
                      context.read<CommentBloc>().add(
                            commentLikeEvent(
                              uuid: data['uuid'],
                              chat_id: chatId,
                              liked: data['thumbsUp'],
                            ),
                          );
                    },
                    icon: Icon(
                      Icons.thumb_up_alt_outlined,
                    ),
                  ),
                  BlocBuilder<CommentBloc, CommentState>(
                    builder: (context, state) {
                      return Text('${data['thumbsUp']}');
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 40,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade200,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      String senderId = data['senderId'];
                      String reciverId = data['reciverId'];
                      List<String> chatRoomId = [reciverId, senderId];
                      chatRoomId.sort();
                      String chatId = chatRoomId.join('_');
                      context.read<CommentBloc>().add(commentDislikeEvent(
                            chat_id: chatId,
                            uuid: data['uuid'],
                            dislike: data['thumbsDawn'],
                          ));
                    },
                    icon: Icon(
                      Icons.thumb_down_alt_outlined,
                    ),
                  ),
                  Text('${data['thumbsDawn']}'),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _chatcont,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Type message here'),
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            await service.putComments(
                reciverId: reciverId, messages: _chatcont.text);
            _chatcont.clear();
          },
          icon: Icon(Icons.arrow_upward),
          color: Colors.blueAccent,
        ),
      ],
    );
  }
}
