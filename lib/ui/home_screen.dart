import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/client/weather_api_client.dart';
import 'package:weather_app/data/entities/weather_current_response.dart';
import 'package:weather_app/data/weather_repository.dart';
import 'package:weather_app/ui/widgets/search_weather_text_field.dart';
import 'package:weather_app/ui/widgets/weather_focast_widget.dart';
import 'package:weather_app/ui/widgets/weather_temperture_info.dart';
import 'package:weather_app/utils/diacritics_util.dart';
import 'package:weather_app/utils/extension/context_extension.dart';
import 'package:weather_app/utils/extension/widget_extension.dart';

import '../data/entities/weather_search_response.dart';
import 'widgets/weather_background.dart';
import 'widgets/weather_location_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final repo = WeatherRepository(WeatherAPIClient.instance);
  final searchCtl = TextEditingController();
  late final ScaffoldMessengerState _scaffoldKey;

  /// * data
  final List<WeatherSearchResponse> currentSearchResults = [];
  Position? _userPosition;
  WeatherSearchResponse? _locationSelected;
  WeatherCurrentResponse? _currentWeather;


  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          WeatherBackground(weather: _currentWeather),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: context.safeTopHeight + 32),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SearchWeatherTextField(
                    controller: searchCtl,
                    onSearch: search,
                    onItemSelect: _onLocationSelected,
                  ),
                ),
                (context.sh * .05).vBox,
                WeatherLocationInfo(info: _currentWeather?.location),
                (context.sh * .05).vBox,
                WeatherTempInfo(info: _currentWeather?.current),
                WeatherForecastWidget()
              ],
            ),
          ),
        ],
      ),
    ).unFocusOutsideClick(context);
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _userPosition = position;
      getCurrentWeather(position.latitude, position.longitude);
    }).catchError((e) {
      debugPrint('error - getCurrentPosition$e');
    });
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

  _onLocationSelected(WeatherSearchResponse locationSelected){
    _locationSelected = locationSelected;
    getCurrentWeather(locationSelected.lat ?? 0, locationSelected.lon ?? 0);
  }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _scaffoldKey.showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _scaffoldKey.showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _scaffoldKey.showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
}