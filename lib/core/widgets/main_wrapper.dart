import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather/core/widgets/app_background.dart';
import 'package:weather/core/widgets/bottom_nav.dart';
import 'package:weather/features/feature_bookmark/presentation/pages/book_mark_screen.dart';
import 'package:weather/features/feature_weather/presentation/pages/home_screen.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({Key? key}) : super(key: key);

  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> pageViewWidget = [
      const HomeScreen(),
      BookMarkScreen(
        pageController: pageController,
      ),
    ];

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AppBackGround.getAppBackGround(),
            fit: BoxFit.fill,
          ),
        ),
        height: height,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: PageView(
            controller: pageController,
            children: pageViewWidget,
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(controller: pageController),
    );
  }
}
