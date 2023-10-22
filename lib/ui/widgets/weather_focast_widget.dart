import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/entities/weather_response.dart';
import 'package:weather_app/provider/setting_provider.dart';
import 'package:weather_app/utils/extension/context_extension.dart';
import 'package:weather_app/utils/extension/date_time_extension.dart';
import 'package:weather_app/utils/extension/widget_extension.dart';

import '../../utils/common_functions.dart';
import 'info_container.dart';
class WeatherForecastWidget extends StatelessWidget {
  const WeatherForecastWidget({super.key,required this.forecast});
  final Forecast? forecast;
  @override
  Widget build(BuildContext context) {
    if(forecast?.forecastDay == null || forecast!.forecastDay.isEmpty) return const SizedBox.shrink();
    return WeatherInfoContainer(
      height: forecast!.forecastDay.isEmpty ? 0 : null,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(12).copyWith(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white.withOpacity(0.5)),
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.black26.withOpacity(0.3),
                    size: 18,
                  ),
              ),
              12.hBox,
              Text('3-5 days forecast', style: context.textTheme.titleMedium),
            ],
          ),
          12.vBox,
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, i) => _ForecastItem(forecastItem: forecast!.forecastDay[i]),
            separatorBuilder: (ctx,i) => 4.vBox,
            itemCount: forecast?.forecastDay.length ?? 0,
          ),
          10.vBox,
          FilledButton(onPressed: (){}, child: const Text('More Details')),
        ],
      ),
    );
  }
}

class _ForecastItem extends StatelessWidget {
  const _ForecastItem({required this.forecastItem});
  final ForecastDay forecastItem;
  @override
  Widget build(BuildContext context) {
    if(forecastItem.date == null) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Image.network(
                addSchemeImgHost(forecastItem.day?.condition?.icon),
                height: 35,
                width: 35,
                errorBuilder: (_,__,___) => const Icon(Icons.cloud, color: Colors.white, size: 35),
              ),
              10.hBox,
              Text(
                '${forecastItem.date!.dayOfWeekStr(todayReplace: true)}\t\t\t\t${forecastItem.day?.condition?.text ?? ''}',
                style: context.textTheme.titleMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: removeZeroDouble(context.read<SettingProvider>().degree(forecastItem.day?.mintempC, forecastItem.day?.mintempF)),
            children: [
              const TextSpan(text:' / '),
              TextSpan(text:removeZeroDouble(context.read<SettingProvider>().degree(forecastItem.day?.maxtempC, forecastItem.day?.maxtempF))),
            ]
          )
        )
      ],
    );
  }
}

