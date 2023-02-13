import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DotLoading extends StatelessWidget {
  const DotLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.halfTriangleDot(
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
