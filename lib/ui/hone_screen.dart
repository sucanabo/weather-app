import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather_app/app/debouncer.dart';
import 'package:weather_app/app/weather_api_client.dart';
import 'package:weather_app/data/weather_repository.dart';

import '../data/weather_search_entity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final repo = WeatherRepository(WeatherAPIClient.instance);
  final searchCtl = TextEditingController();
  final searchDebouncer = Debouncer(milliseconds: 300);

  /// * data
  final List<WeatherSearchResponse> currentSearchResults = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        TypeAheadFormField<WeatherSearchResponse>(
        textFieldConfiguration: TextFieldConfiguration(
            controller: searchCtl,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter location...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                    onPressed: () {
                      searchCtl.clear();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.black.withOpacity(0.6),
                    )))),
        debounceDuration: const Duration(milliseconds: 500),
        suggestionsCallback: search,
        itemBuilder: (context, WeatherSearchResponse suggestion) {
          // final location = suggestion;
          // String title = location.type == 'POI'
          //     ? '${location.poi.name} - ${location.address.municipalitySubdivision ?? ''} - ${location.address.freeformAddress}'
          //     : '${location.address.municipalitySubdivision ?? ''} - ${location.address.freeformAddress}';
          return Column(
            children: [
              ListTile(
                title: Text(suggestion.name ?? ''),
                leading: const Icon(Icons.location_on_rounded),

              ),
            ],
          );
          //return Center(child: Text(LocaleKeys.no_item_found.tr()));
        },
        hideOnError: true,
        onSuggestionSelected: (WeatherSearchResponse suggestion) {
          //setLocation(suggestion);
        },
              // noItemsFoundBuilder: (context) => Container(
              //     height: 100.0,
              //     child: Center(
              //       child: Text(LocaleKeys.no_item_found.tr()),
              //     )),
            )
          ],
        ),
      ),
    );
  }
  Future<List<WeatherSearchResponse>> search(String str) async {
   try{
     return await repo.searchLocation(str);
   } catch (e){
     debugPrint('Erro seach - $e');
     return [];
   }
  }
}


