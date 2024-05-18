import 'package:chat/pages/Home/home.dart';
import 'package:chat/pages/signin%20&%20signup/bloc/auth_bloc.dart';
import 'package:chat/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

MaterialButton button(
  VoidCallback? onpressed,
  double? width,
  double? size,
  String message,
  BuildContext contextt,
) {
  return MaterialButton(
    color: secondaryColor,
    onPressed: onpressed,
    height: 60,
    elevation: 10,
    minWidth: width,
    child: Text(
      message,
      style: TextStyle(
        color: Colors.grey.shade500,
        fontSize: size,
      ),
    ),
  );
}
