import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather_app/data/client/weather_api_client.dart';
import 'package:weather_app/data/entities/weather_current_response.dart';
import 'package:weather_app/data/weather_repository.dart';
import 'package:weather_app/utils/diacritics_util.dart';

import '../data/entities/weather_search_response.dart';
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
            child: Container(
              padding: const EdgeInsets.all(16).copyWith(top: MediaQuery.of(context).viewPadding.top),
              child: Column(
                children: [
                  TypeAheadFormField<WeatherSearchResponse>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: searchCtl,
                      textInputAction: TextInputAction.search,
                      onSubmitted: search,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter location...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          onPressed: () => searchCtl.clear(),
                          icon: Icon(
                            Icons.close,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                    debounceDuration: const Duration(milliseconds: 150),
                    suggestionsCallback: search,
                    itemSeparatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, WeatherSearchResponse suggestion) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(suggestion.name ?? ''),
                            leading: const Icon(Icons.location_on_rounded),
                          ),
                        ],
                      );
                    },
                    hideOnError: true,
                    onSuggestionSelected: _onLocationSelected,
                    noItemsFoundBuilder: (context) =>  Container(
                        height: 100.0,
                        alignment: Alignment.center,
                        child: const Text("Not found location."),
                    ),
                  ),
                  if(_currentWeather != null)...[
                   Text(_currentWeather!.location?.country ?? "Unknown country"),
                   Text("${_currentWeather!.current?.tempC ?? 0} C")
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
