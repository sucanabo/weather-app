import 'package:flutter/material.dart';
import 'package:weather_app/data/entities/weather_response.dart';
import 'package:weather_app/ui/widgets/info_container.dart';
import 'package:weather_app/utils/common_functions.dart';
import 'package:weather_app/utils/extension/context_extension.dart';

import '../../utils/enums.dart';
class WeatherOtherInformationWidget extends StatelessWidget {
  const WeatherOtherInformationWidget({super.key, this.currentWeather});
  final Current? currentWeather;

  @override
  Widget build(BuildContext context) {
    return WeatherInfoContainer(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _InfoItem(title:'Humidity', value: currentWeather?.humidity ?? 0,unit:'%'),
          _InfoItem(
              title: 'Real feel',
              value: currentWeather?.feelslikeC ?? 0,
              unit: getDegreeSymbol(TempDegreeMode.c,noCharUnit: true),
          ),
          _InfoItem(title:'UV', value: currentWeather?.uv ?? 0),
          _InfoItem(
            title: 'Pressure',
            value: currentWeather?.pressureMb ?? 0,
            unit: 'mbar',
            unitStyle: context.textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
          _InfoItem(
            title: 'Wind',
            value: currentWeather?.pressureMb ?? 0,
            unit: 'mph',
            unitStyle: context.textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
          _InfoItem(title:'Cloud', value: currentWeather?.cloud ?? 0,unit:'%',hasDivider: false),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    super.key,
    required this.title,
    required this.value,
    this.unit,
    this.hasDivider = true,
    this.unitStyle,
  });
  final String title;
  final num value;
  final String? unit;
  final TextStyle? unitStyle;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              title,
              style: context.textTheme.titleMedium,
            )),
            Text.rich(
              TextSpan(
                text: removeZeroDouble(value),
                children: [
                  if (unit != null) TextSpan(text: unit ?? '', style: unitStyle)
                ],
              ),
              style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ],
        ),
        if(hasDivider) Divider(color: Colors.white.withOpacity(.4),height: 12)
      ],
    );
  }
}

