import 'package:flutter/material.dart';
import 'package:weather/core/utils/constants.dart';

class BottomNav extends StatelessWidget {
  PageController controller;
  BottomNav({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: BottomAppBar(
        color: Constants.bottomNavColor,
        child: SizedBox(
          height: height / 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  controller.animateToPage(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                icon: const Icon(
                  Icons.home,
                  size: 27,
                  color: Colors.white,
                ),
              ),
              const SizedBox(),
              IconButton(
                onPressed: () {
                  controller.animateToPage(1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                icon: const Icon(
                  Icons.bookmark,
                  size: 27,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
