part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class loginRequestedSuccessState extends AuthState {
  final userDetail userData;
  loginRequestedSuccessState({
    required this.userData,
  });
}

final class signUpRequestedSuccessState extends AuthState {
  final userDetail userData;
  signUpRequestedSuccessState({
    required this.userData,
  });
}

final class failureState extends AuthState {
  final String error;
  failureState({
    required this.error,
  });
}

final class LoadingState extends AuthState {}
