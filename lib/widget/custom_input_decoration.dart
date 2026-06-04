import 'package:flutter/material.dart';
import 'package:zournel/const.dart';

InputDecoration customInputDecoration({
  required String label,
  required IconData icon,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    filled: true,
    fillColor: textFieldFillColor,

    labelText: label,
    labelStyle: textFieldLabelStyle,

    prefixIcon: Icon(icon, color: primaryColor),

    suffixIcon: suffixIcon,

    contentPadding: const EdgeInsets.symmetric(vertical: 18),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: primaryColor, width: 1.5),
    ),
  );
}
