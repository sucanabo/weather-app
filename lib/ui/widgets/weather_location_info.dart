import 'package:flutter/material.dart';
import 'package:weather_app/data/entities/weather_response.dart';
import 'package:weather_app/utils/extension/context_extension.dart';
import 'package:weather_app/utils/extension/date_time_extension.dart';

import '../../utils/common_functions.dart';

class WeatherLocationInfo extends StatelessWidget {
  const WeatherLocationInfo({super.key, this.info});
  final Location? info;

  String get countryAndDateStr {
    final cStr = info?.country ?? 'Unknown Country';
    final dStr = (dateTimeOrNull(info?.localtime) ?? DateTime.now()).uiDate;
    return '$cStr - $dStr';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            info?.name ?? "Unknown City",
            style: context.textTheme.displaySmall?.copyWith(color: Colors.white),
          ),
          Text(
            countryAndDateStr,
            style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
