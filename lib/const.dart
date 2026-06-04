// lib/const/app_theme.dart

import 'package:flutter/material.dart';

/// ================= COLORS =================

const Color appBarColor = Colors.deepPurple;

const Color primaryColor = appBarColor;

const Color secondaryColor = Colors.white;

const Color blackColor = Colors.black;

const Color redColor = Colors.red;
const Color redColorAccent = Colors.redAccent;

const Color transparentColor = Colors.transparent;

const Color gradientStartColor = Color(0xff6D5DF6);

const Color gradientEndColor = Color(0xff8E7CFF);

const Color scaffoldBgColor = Color(0xffF8F9FD);

final Color greyShade600 = Colors.grey.shade600;

final Color textFieldFillColor = Colors.grey.shade100;

/// ================= TEXT STYLES =================

const TextStyle appBarTitleStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: secondaryColor,
);

const TextStyle screenHeaderStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: blackColor,
);

const TextStyle buttonTextStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.bold,
  color: secondaryColor,
);

const TextStyle cardTitleTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: blackColor,
  fontFamily: 'Lato',
);

const TextStyle cardDescTextStyle = TextStyle(
  fontSize: 15,
  color: blackColor,
  fontFamily: 'Lato',
);

final TextStyle cardDateTextStyle = TextStyle(
  fontSize: 14,
  color: greyShade600,
  fontFamily: 'Lato',
);

const TextStyle emptyTitleStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.bold,
  color: blackColor,
);

final TextStyle emptyDescStyle = TextStyle(
  fontSize: 16,
  color: greyShade600,
  height: 1.5,
);

final TextStyle subtitleStyle = TextStyle(fontSize: 15, color: greyShade600);

const TextStyle textFieldLabelStyle = TextStyle(
  fontSize: 16,
  color: blackColor,
);

const TextStyle textFieldTextStyle = TextStyle(fontSize: 16, color: blackColor);
final TextStyle boldTextStyle = TextStyle(fontWeight: FontWeight.bold);
