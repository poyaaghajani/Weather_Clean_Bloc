import 'package:flutter/material.dart';
import 'package:weather/core/utils/date_converter.dart';
import 'package:weather/core/widgets/sett_icon.dart';
import 'package:weather/features/feature_weather/data/models/forecast_days_model.dart';

class DaysWeatherView extends StatefulWidget {
  final Daily daily;
  const DaysWeatherView({super.key, required this.daily});

  @override
  State<DaysWeatherView> createState() => _DaysWeatherViewState();
}

class _DaysWeatherViewState extends State<DaysWeatherView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween(
      begin: -1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1, curve: Curves.decelerate),
      ),
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform(
          transform:
              Matrix4.translationValues(animation.value * width, 0.0, 0.0),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            color: Colors.transparent,
            elevation: 0,
            child: SizedBox(
              width: width / 4.2,
              child: Column(
                children: [
                  Text(
                    DateConverter.changeDtToDateTime(widget.daily.dt),
                    style: TextStyle(
                      fontSize: width / 29,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: height / 200),
                  SizedBox(
                    width: width / 6,
                    child: SetIcon.setIconForMain(
                      widget.daily.weather![0].description,
                    ),
                  ),
                  SizedBox(height: height / 150),
                  Text(
                    "${widget.daily.temp!.day!}\u00B0",
                    style: TextStyle(fontSize: width / 23, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
