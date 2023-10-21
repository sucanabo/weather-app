import 'package:flutter/material.dart';
import 'package:weather_app/data/entities/weather_response.dart';
import 'package:weather_app/ui/widgets/temp_widget.dart';
import 'package:weather_app/utils/extension/context_extension.dart';
import 'package:weather_app/utils/extension/widget_extension.dart';

import '../../utils/common_functions.dart';

class WeatherTempInfo extends StatelessWidget {
  const WeatherTempInfo({super.key, this.info});
  final Current? info;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          TempWidget(temp: info?.tempC ?? 0,tempSize: 110),
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
