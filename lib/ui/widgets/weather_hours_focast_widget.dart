import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/entities/weather_response.dart';
import 'package:weather_app/ui/widgets/info_container.dart';
import 'package:weather_app/ui/widgets/temp_widget.dart';
import 'package:weather_app/utils/extension/context_extension.dart';
import 'package:weather_app/utils/extension/date_time_extension.dart';
import 'package:weather_app/utils/extension/widget_extension.dart';

import '../../provider/setting_provider.dart';
import '../../utils/common_functions.dart';
class WeatherHoursForecastWidget extends StatefulWidget {
  const WeatherHoursForecastWidget({super.key,this.hours = const []});
  final List<Hour> hours;

  @override
  State<WeatherHoursForecastWidget> createState() => _WeatherHoursForecastWidgetState();
}

class _WeatherHoursForecastWidgetState extends State<WeatherHoursForecastWidget> {
  final _sController = ScrollController();
  final _now = DateTime.now();
  int? activeIndex;
  @override
  void initState() {
    super.initState();
    updateHour();
  }

  @override
  void didUpdateWidget(WeatherHoursForecastWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.key != widget.key){
      updateHour();
    }
  }

    updateHour(){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        activeIndex = findCurrentHour();
        _sController.animateTo(
          (100 + 8) * (activeIndex ?? 0).toDouble(),
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
        ).then((value) => mounted ?setState((){}) : null);
      });
    }
   int findCurrentHour(){
    for(var i = 0; i < widget.hours.length; i++){
      if(dateTimeOrNull(widget.hours[i].time)?.hour == _now.hour){
        return i;
      }
    }
    return 0;
  }


  @override
  Widget build(BuildContext context) {
    return WeatherInfoContainer(
      height: widget.hours.isEmpty ? 0 : null,
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
            height: 125,
            child: ListView.separated(
              controller: _sController,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => _ForecastItem(
                hour: widget.hours[i],
                isActive: activeIndex == i,
              ),
              separatorBuilder: (ctx,i) => 8.hBox,
              itemCount: widget.hours.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _ForecastItem extends StatelessWidget {
  const _ForecastItem({required this.hour,this.isActive = false});
  final Hour hour;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final dateF = dateTimeOrNull(hour.time);
    if(dateF == null) return const SizedBox.shrink();
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? context.colors.primary.withOpacity(0.5) : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isActive ? 'Now' : dateTimeOrNull(hour.time)?.hourWithA ?? '',
            style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
          ),
          Expanded(
            child: Image.network(
              addSchemeImgHost(hour.condition?.icon),
              height: 40,
              width: 40,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.cloud,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          TempWidget(
            temp: context.read<SettingProvider>().degree(hour.tempC, hour.tempF),
            tempSize: 16,
            supRight: -16,
            tempTextStyle: context.textTheme.titleSmall?.copyWith(color: Colors.white),
            supTextStyle: context.textTheme.titleSmall?.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}

