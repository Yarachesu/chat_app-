part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class commentLikeEvent extends CommentEvent {
  int liked;
  String chat_id;
  String uuid;

  commentLikeEvent({
    required this.liked,
    required this.chat_id,
    required this.uuid,
  });
}

class commentDislikeEvent extends CommentEvent {
  int dislike;
  String chat_id;
  String uuid;
  commentDislikeEvent({
    required this.dislike,
    required this.chat_id,
    required this.uuid,
  });
}

class commentDeleteEvent extends CommentEvent {
  final String uuid;
  final String chatId;
  commentDeleteEvent({
    required this.chatId,
    required this.uuid,
  });
}
