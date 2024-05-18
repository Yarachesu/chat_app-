import 'package:bloc/bloc.dart';
import 'package:chat/services/blocs/bloc/comment_bloc.dart';
import 'package:chat/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class bubble extends StatelessWidget {
  final bool iscurrentUser;
  final String message;
  final String uuid;
  final String chatId;
  const bubble({
    super.key,
    required this.uuid,
    required this.chatId,
    required this.iscurrentUser,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            width: 150,
            child: SimpleDialog(
              title: Text('Do you want to delete this message ? '),
              children: [
                Column(
                  children: [
                    MaterialButton(
                      minWidth: 90,
                      height: 60,
                      color: Colors.red.shade400,
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: secondaryColor,
                        ),
                      ),
                      onPressed: () {
                        context.read<CommentBloc>().add(
                            commentDeleteEvent(chatId: chatId, uuid: uuid));
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      child: Container(
        height: 70,
        width: 150,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: iscurrentUser ? Colors.greenAccent : secondaryColor,
            borderRadius: BorderRadius.circular(10)),
        alignment: iscurrentUser ? Alignment.bottomRight : Alignment.bottomLeft,
        child: BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            return Text(
              message,
              style: TextStyle(
                fontSize: 15,
              ),
            );
          },
        ),
      ),
    );
  }
}
