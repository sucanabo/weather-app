import 'package:flutter/material.dart';
import 'package:weather_app/data/entities/weather_response.dart';
import 'package:weather_app/ui/widgets/temp_widget.dart';
import 'package:weather_app/utils/extension/context_extension.dart';
import 'package:weather_app/utils/extension/date_time_extension.dart';
import 'package:weather_app/utils/extension/widget_extension.dart';

import '../../utils/common_functions.dart';
class WeatherHoursForecastWidget extends StatefulWidget {
  const WeatherHoursForecastWidget({super.key,this.hours = const []});
  final List<Hour> hours;

  @override
  State<WeatherHoursForecastWidget> createState() => _WeatherHoursForecastWidgetState();
}

class _WeatherHoursForecastWidgetState extends State<WeatherHoursForecastWidget> {


  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      height: widget.hours.isEmpty ? 0 : null,
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.3),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 12),
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
                    Icons.access_time_filled,
                    color: Colors.black26.withOpacity(0.3),
                    size: 18,
                  ),
              ),
              12.hBox,
              Text('24-hour forecast', style: context.textTheme.titleMedium),
            ],
          ),
          12.vBox,
          SizedBox(
            height: 160,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => _ForecastItem(hour: widget.hours[i]),
              separatorBuilder: (ctx,i) => 12.hBox,
              itemCount: widget.hours.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _ForecastItem extends StatefulWidget {
  const _ForecastItem({required this.hour});
  final Hour hour;

  @override
  State<_ForecastItem> createState() => _ForecastItemState();
}

class _ForecastItemState extends State<_ForecastItem> {
  final _key = GlobalKey();
  late final DateTime? dateF;
  bool isActive = false;

  @override
  void initState(){
    super.initState();
    dateF = dateTimeOrNull(widget.hour.time);
    isActive = DateTime.now().hour == dateF?.hour;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(isActive){
        Scrollable.ensureVisible(_key.currentState!.context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    if(dateF == null) return const SizedBox.shrink();
    return Container(
      key: _key,
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? context.colors.primary.withOpacity(0.5) : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12)
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dateTimeOrNull(widget.hour.time)?.hourWithA ?? '',
            style: context.textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
          Expanded(
            child: Image.network(
              addSchemeImgHost(widget.hour.condition?.icon),
              errorBuilder: (_, __, ___) => const Icon(
                Icons.cloud,
                color: Colors.white,
              ),
            ),
          ),
          TempWidget(
            temp: widget.hour.tempC ?? 0,
            tempSize: 18,
            supRight: -16,
            tempTextStyle: context.textTheme.titleLarge?.copyWith(color: Colors.white),
            supTextStyle: context.textTheme.titleSmall?.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}

