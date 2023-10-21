import 'package:flutter/material.dart';
import 'package:weather_app/data/client/weather_api_client.dart';
import 'package:weather_app/data/entities/weather_current_response.dart';
import 'package:weather_app/data/weather_repository.dart';
import 'package:weather_app/ui/widgets/search_weather_text_field.dart';
import 'package:weather_app/utils/common_functions.dart';
import 'package:weather_app/utils/diacritics_util.dart';
import 'package:weather_app/utils/extension/context_extension.dart';
import 'package:weather_app/utils/extension/widget_extension.dart';

import '../data/entities/weather_search_response.dart';
import '../utils/extension/date_time_extension.dart';
import 'widgets/weather_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final repo = WeatherRepository(WeatherAPIClient.instance);
  final searchCtl = TextEditingController();

  /// * data
  final List<WeatherSearchResponse> currentSearchResults = [];
  WeatherSearchResponse? _locationSelected;
  WeatherCurrentResponse? _currentWeather;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          WeatherBackground(weather: _currentWeather),
          Positioned(
            top: context.safeTopHeight + 32,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchWeatherTextField(
                controller: searchCtl,
                onSearch: search,
                onItemSelect: _onLocationSelected,
              ),
            ),
          ),
          Positioned(
            top: context.sh * .18,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                      _currentWeather?.location?.name ?? "Unknown City",
                      style: context.textTheme.displayMedium,
                  ),
                  Text(
                      '${_currentWeather?.location?.country ?? 'Unknown Country'} - ${(dateTimeOrNull(_currentWeather?.location?.localtime) ?? DateTime.now()).uiDate}',
                      style: context.textTheme.titleMedium,
                  ),
                  20.vBox,
                  Text(
                    '${_currentWeather?.current?.tempC ?? '0'}',
                    style: const TextStyle(fontSize: 70, color: Colors.white),
                  ).withSuperscript(' \u2103', const TextStyle(fontSize: 45, color: Colors.white))
                ],
              ),
            ),
          ),
        ],
      ),
    ).unFocusOutsideClick(context);
  }

  _onLocationSelected(WeatherSearchResponse locationSelected){
    _locationSelected = locationSelected;
    getCurrentWeather(locationSelected.lat ?? 0, locationSelected.lon ?? 0);
  }

  Future<void> getCurrentWeather(num lat, num lng) async {
    try{
      return await repo.getWeatherByLatLng(lat, lng).then((res){
        if(res != null){
          _currentWeather = res;
          setState(() {});
        }
      });
    } catch (e){
      debugPrint("[Error] when getCurrentWeather: $e");
    }
  }
  Future<List<WeatherSearchResponse>> search(String str) async {
    if(str.isEmpty) return [];
    try {
      return await repo.searchLocation(str.withoutDiacritics);
    } catch (e) {
      debugPrint('Error search - $e');
      return [];
    }
  }
}
