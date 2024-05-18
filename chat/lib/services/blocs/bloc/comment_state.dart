part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class commentLikeState extends CommentState {}

final class commentDislikeState extends CommentState {}

final class commentDeleteState extends CommentState {}
