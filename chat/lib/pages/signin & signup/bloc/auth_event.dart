part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class loginRequestedEvent extends AuthEvent {
  final userDetail userData;
  loginRequestedEvent({
    required this.userData,
  });
}

final class signUpRequestedEvent extends AuthEvent {
  final userDetail userData;
  signUpRequestedEvent({
    required this.userData,
  });
}

final class loadingEvent extends AuthEvent {}
