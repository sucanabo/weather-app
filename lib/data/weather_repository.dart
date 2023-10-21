import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:weather_app/data/client/weather_api_client.dart';
import 'package:weather_app/data/entities/location_search_response.dart';
import 'package:weather_app/data/entities/weather_response.dart';

class WeatherRepository {
  final WeatherAPIClient client;
  const WeatherRepository(this.client);
  
  Future<List<LocationSearchResponse>> searchLocation(String searchString) async {
    try{
      return await client.dio.get(
        'search.json',
        queryParameters: {'q': searchString},
      ).then((res) {
        if(res.statusCode == HttpStatus.ok){
          if(res.data is List){
            return (res.data as List).map((e) => LocationSearchResponse.fromJson(e)).toList();
          }
          return [LocationSearchResponse.fromJson(res.data)];
        }
        return [];
      });
    } catch (e){
      debugPrint('[ERROR] searchLocation $e');
      rethrow;
    }
  }
  Future<WeatherResponse?> getWeatherByLatLng(num lat, num lng) async {
    try{
      return await client.dio.get(
        'forecast.json',
        queryParameters: {
          'q': '$lat,$lng',
          'days': 7,
        },
      ).then((res) {
        if(res.statusCode == HttpStatus.ok){
          return WeatherResponse.fromJson(res.data);
        }
        return null;
      });
    } catch (e){
      debugPrint('[ERROR] getCurrentWeather $e');
      rethrow;
    }
  }
}