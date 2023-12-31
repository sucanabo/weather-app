import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather_app/data/entities/location_search_response.dart';
import 'package:weather_app/router/route_name.dart';
import 'package:weather_app/utils/extension/context_extension.dart';
class SearchWeatherTextField extends StatelessWidget {
  const SearchWeatherTextField({super.key, this.controller, required this.onSearch, required this.onItemSelect});
  final TextEditingController? controller;
  final SuggestionsCallback<LocationSearchResponse> onSearch;
  final void Function(LocationSearchResponse) onItemSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TypeAheadFormField<LocationSearchResponse>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: controller,
            textInputAction: TextInputAction.search,
            onSubmitted: onSearch,
            decoration: InputDecoration(
              hintStyle: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.5)
              ),
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white38)
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              hintText: 'Enter city name...',
              prefixIcon: Icon(Icons.search,color: Colors.white.withOpacity(0.7)),
              suffix: InkWell(
                onTap: () => controller?.clear(),
                child: Icon(
                  Icons.close,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          ),
          debounceDuration: const Duration(milliseconds: 150),
          suggestionsCallback: onSearch,
          itemSeparatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, LocationSearchResponse suggestion) {
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
          onSuggestionSelected: onItemSelect,
          noItemsFoundBuilder: (context) =>  Container(
            height: 100.0,
            alignment: Alignment.center,
            child: const Text("Not found location."),
          ),
        )),
        IconButton(onPressed: (){
          Navigator.pushNamed(context, RouteName.setting);
        }, icon: const Icon(Icons.settings_outlined,color: Colors.white)),
      ],
    );
  }
}
