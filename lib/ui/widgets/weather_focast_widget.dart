import 'package:flutter/material.dart';
import 'package:weather_app/data/entities/weather_response.dart';
import 'package:weather_app/utils/extension/context_extension.dart';
import 'package:weather_app/utils/extension/date_time_extension.dart';
import 'package:weather_app/utils/extension/widget_extension.dart';

import '../../utils/common_functions.dart';
class WeatherForecastWidget extends StatefulWidget {
  const WeatherForecastWidget({super.key,required this.forecast});
  final Forecast? forecast;
  @override
  State<WeatherForecastWidget> createState() => _WeatherForecastWidgetState();
}

class _WeatherForecastWidgetState extends State<WeatherForecastWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.forecast?.forecastDay == null || widget.forecast!.forecastDay.isEmpty) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.3),
        borderRadius: BorderRadius.circular(12),
      ),
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
            itemBuilder: (ctx, i) => _ForecastItem(forecastItem: widget.forecast!.forecastDay[i]),
            separatorBuilder: (ctx,i) => 4.vBox,
            itemCount: widget.forecast?.forecastDay.length ?? 0,
          )
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
            text: '${forecastItem.day?.mintempC}',
            children: [
              const TextSpan(text:' / '),
              TextSpan(text:'${forecastItem.day?.maxtempC}'),
            ]
          )
        )
      ],
    );
  }
}

