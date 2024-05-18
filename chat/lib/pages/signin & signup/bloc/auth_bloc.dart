import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/auth/authentication.dart';
import 'package:chat/modals/userDetailModel.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<loginRequestedEvent>(_loginRequestedEvent);
    on<signUpRequestedEvent>(_signUpRequestedEvent);
    on<loadingEvent>(_loadingEvent);
  }
  FutureOr<void> _loadingEvent(
    loadingEvent event,
    Emitter emit,
  ) {
    emit(LoadingState());
  }

  FutureOr<void> _loginRequestedEvent(
    loginRequestedEvent event,
    Emitter emit,
  ) async {
    emit(LoadingState());
    try {
      String result = await authServices().signInUser(
        email: event.userData.toMap()['email'],
        password: event.userData.toMap()['password'],
        name: event.userData.toMap()['firstName'],
      );
      if (result == 'success') {
        emit(
          loginRequestedSuccessState(
            userData: userDetail(
              email: event.userData.toMap()['email'],
              LastName: event.userData.toMap()['lastName'],
              firstName: event.userData.toMap()['firstName'],
              password: event.userData.toMap()['password'],
              uid: event.userData.toMap()['uid'],
            ),
          ),
        );
      } else {
        emit(
          failureState(error: 'Error: wrong email or password.'),
        );
      }
    } catch (e) {
      emit(
        failureState(error: e.toString()),
      );
    }
  }

  FutureOr<void> _signUpRequestedEvent(
    signUpRequestedEvent event,
    Emitter emit,
  ) async {
    emit(LoadingState());
    try {
      String result = await authServices().signUpUser(
        firstname: event.userData.toMap()['firstName'],
        Lastname: event.userData.toMap()['lastName'],
        email: event.userData.toMap()['email'],
        password: event.userData.toMap()['password'],
        confirmPassword: event.userData.toMap()['password'],
      );
      if (result == 'success') {
        emit(
          loginRequestedSuccessState(
            userData: userDetail(
              email: event.userData.toMap()['email'],
              LastName: event.userData.toMap()['lastName'],
              firstName: event.userData.toMap()['firstName'],
              password: event.userData.toMap()['password'],
              uid: event.userData.toMap()['uid'],
            ),
          ),
        );
      } else {
        emit(
          failureState(error: 'Error: wrong email or password.'),
        );
      }
    } catch (e) {
      emit(
        failureState(error: e.toString()),
      );
    }
  }
}
