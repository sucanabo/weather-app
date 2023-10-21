import 'package:flutter/material.dart';
import 'package:weather_app/data/entities/weather_current_response.dart';
import 'package:weather_app/utils/common_functions.dart';

import '../../utils/app_colors.dart';

class WeatherBackground extends StatefulWidget {
  const WeatherBackground({super.key,
    this.weather,
    this.duration = const Duration(milliseconds: 300),
  });

  final WeatherCurrentResponse? weather;
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
  Color startColor = AppColors.earlyMorningColor;
  Color endColor = AppColors.nightColor;

  @override
  void initState() {
    super.initState();
    initBgColor();
  }
  initBgColor(){
    final timeIndex = calculateTime(dateTimeOrNull(widget.weather?.location?.localtime) ?? DateTime.now());
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
    if(h < 5 || h > 20) return 5;
    if(h < 9) return 0;
    if(h < 13) return 1;
    if(h < 16) return 2;
    if(h < 18) return 3;
    if(h < 20) return 4;
    return 0;
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
