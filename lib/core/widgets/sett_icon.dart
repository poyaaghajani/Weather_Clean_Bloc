import 'package:flutter/material.dart';

class SetIcon {
  static Image setIconForMain(description) {
    if (description == "clear sky") {
      return const Image(
        image: AssetImage(
          'assets/images/icons8-sun-96.png',
        ),
      );
    } else if (description == "few clouds") {
      return const Image(
          image: AssetImage('assets/images/icons8-partly-cloudy-day-80.png'));
    } else if (description.contains("clouds")) {
      return const Image(
          color: Colors.white,
          image: AssetImage('assets/images/icons8-clouds-80.png'));
    } else if (description.contains("thunderstorm")) {
      return const Image(
          image: AssetImage('assets/images/icons8-storm-80.png'));
    } else if (description.contains("drizzle")) {
      return const Image(
          image: AssetImage('assets/images/icons8-rain-cloud-80.png'));
    } else if (description.contains("rain")) {
      return const Image(
          image: AssetImage('assets/images/icons8-heavy-rain-80.png'));
    } else if (description.contains("snow")) {
      return const Image(image: AssetImage('assets/images/icons8-snow-80.png'));
    } else {
      return const Image(
          image: AssetImage('assets/images/icons8-windy-weather-80.png'));
    }
  }
}
