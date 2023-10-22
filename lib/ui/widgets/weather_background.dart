import 'package:flutter/material.dart';
import 'package:weather_app/utils/common_functions.dart';

import '../../utils/app_colors.dart';

class WeatherBackground extends StatefulWidget {
  const WeatherBackground({super.key,
    this.localTime,
    this.duration = const Duration(milliseconds: 300),
  });

  final DateTime? localTime;
  final Duration duration;

  @override
  State<WeatherBackground> createState() => _WeatherBackgroundState();
}

class _WeatherBackgroundState extends State<WeatherBackground> {
  final List<Color> timeColors = [
    AppColors.earlyMorningColor,
    AppColors.lateMorningColor,
    AppColors.earlyAfternoon,
    AppColors.lateAfternoonColor,
    AppColors.eveningColor,
    AppColors.nightColor,
  ];
  int timeIndex = 0;
  late Color startColor;
  late Color endColor;

  @override
  void initState() {
    super.initState();
    initBgColor();
  }


  @override
  void didUpdateWidget(WeatherBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.localTime?.microsecondsSinceEpoch != widget.localTime?.microsecondsSinceEpoch){
      initBgColor();
    }
  }

  initBgColor(){
    final timeIndex = calculateTime(dateTimeOrNull(widget.localTime) ?? DateTime.now());
    startColor = timeColors[timeIndex];
    if(timeIndex == timeColors.length - 1){
      endColor = timeColors[0];
      return setState(() {});
    }
    endColor = timeColors[timeIndex + 1];
    setState(() {});
  }

  int calculateTime(DateTime dateTime){
    final h = dateTime.hour;
    if(h < 5) return 5;
    if(h < 9) return 0;
    if(h < 13) return 1;
    if(h < 16) return 2;
    if(h < 18) return 3;
    return 4;
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [startColor,endColor]
        )
      ),
    );
  }
}
