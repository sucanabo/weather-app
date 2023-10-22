import 'package:flutter/material.dart';

class WeatherInfoContainer extends StatelessWidget {
  const WeatherInfoContainer({super.key, required this.child,this.margin,this.padding,this.height});
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
