import 'package:chat/utils/theme.dart';
import 'package:flutter/material.dart';

TextField TextFormfields(
  TextEditingController controller,
  String message,
  Icon prifix_icon,
  Color prifix_color,
) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      fillColor: primeryColor,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: secondaryColor, width: 0),
        borderRadius: BorderRadius.circular(10),
      ),
      label: Text(message),
      prefixIcon: prifix_icon,
      prefixIconColor: prifix_color,
    ),
  );
}
