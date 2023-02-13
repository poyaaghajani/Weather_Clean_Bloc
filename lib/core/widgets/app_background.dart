import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppBackGround {
  static AssetImage getAppBackGround() {
    DateTime now = DateTime.now();

    String formatDate = DateFormat('kk').format(now);

    if (5 < int.parse(formatDate) && 16 > int.parse(formatDate)) {
      return const AssetImage('assets/images/day3.png');
    }
    if (16 <= int.parse(formatDate) && 21 > int.parse(formatDate)) {
      return const AssetImage('assets/images/mid_night.png');
    } else {
      return const AssetImage('assets/images/night1.png');
    }
  }
}
