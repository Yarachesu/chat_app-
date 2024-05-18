import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<commentLikeEvent>(CommentLikeEvent);
    on<commentDislikeEvent>(CommentDislikeEvent);
    on<commentDeleteEvent>(CommentDeleteEvent);
  }

  FutureOr<void> CommentDeleteEvent(
    commentDeleteEvent event,
    Emitter<CommentState> emit,
  ) {
    deleteCommentMessage(
      chatId: event.chatId,
      uuid: event.uuid,
    );
    emit(commentDeleteState());
  }

  FutureOr<void> CommentLikeEvent(
    commentLikeEvent event,
    Emitter<CommentState> emit,
  ) {
    event.liked = event.liked + 1;
    updateLikedData(
      liked: event.liked,
      chat_id: event.chat_id,
      uuid: event.uuid,
    );

    emit(commentLikeState());
  }

  FutureOr<void> CommentDislikeEvent(
      commentDislikeEvent event, Emitter<CommentState> emit) {
    event.dislike = event.dislike + 1;
    updateDisLikedData(
      Disliked: event.dislike,
      uuid: event.uuid,
      chat_id: event.chat_id,
    );
    emit(commentDislikeState());
  }

  Future<void> updateDisLikedData({
    required Disliked,
    required String uuid,
    required String chat_id,
  }) async {
    await FirebaseFirestore.instance
        .collection('char_room')
        .doc(chat_id)
        .collection('messages')
        .doc(uuid)
        .update({
      'thumbsDawn': Disliked,
    });
  }

  Future<void> updateLikedData({
    required liked,
    required String uuid,
    required String chat_id,
  }) async {
    await FirebaseFirestore.instance
        .collection('char_room')
        .doc(chat_id)
        .collection('messages')
        .doc(uuid)
        .update({
      'thumbsUp': liked,
    });
  }

  Future<void> deleteCommentMessage({
    required String chatId,
    required String uuid,
  }) async {
    await FirebaseFirestore.instance
        .collection('char_room')
        .doc(chatId)
        .collection('messages')
        .doc(uuid)
        .delete();
  }
}
