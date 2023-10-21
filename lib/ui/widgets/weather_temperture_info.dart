import 'package:flutter/material.dart';
import 'package:weather_app/data/entities/weather_current_response.dart';
import 'package:weather_app/utils/extension/context_extension.dart';
import 'package:weather_app/utils/extension/date_time_extension.dart';
import 'package:weather_app/utils/extension/widget_extension.dart';

import '../../utils/common_functions.dart';

class WeatherTempInfo extends StatelessWidget {
  const WeatherTempInfo({super.key, this.info});

  final Current? info;

  String get tempStr => removeZeroDouble(info?.tempC ?? 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Text(
                tempStr,
                style: const TextStyle(
                  fontSize: 110,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  height: 1.1,
                ),
              ),
              const Positioned(
                top: 10,
                right: -35,
                child: Text(
                  '\u2103',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                addSchemeImgHost(info?.condition?.icon),
                height: 30,
                width: 30,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
              10.hBox,
              Text(
                info?.condition?.text ?? '',
                style: context.textTheme.titleMedium?.copyWith(color: Colors.white),
              ),
            ],
          )
        ],

      ),
    );
  }
}
