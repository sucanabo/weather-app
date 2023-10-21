import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:weather_app/data/client/weather_api_client.dart';
import 'package:weather_app/data/entities/weather_current_response.dart';
import 'package:weather_app/data/entities/weather_search_response.dart';

class WeatherRepository {
  final WeatherAPIClient client;
  const WeatherRepository(this.client);
  
  Future<List<WeatherSearchResponse>> searchLocation(String searchString) async {
    try{
      return await client.dio.get(
        'search.json',
        queryParameters: {'q': searchString},
      ).then((res) {
        if(res.statusCode == HttpStatus.ok){
          if(res.data is List){
            return (res.data as List).map((e) => WeatherSearchResponse.fromJson(e)).toList();
          }
          return [WeatherSearchResponse.fromJson(res.data)];
        }
        return [];
      });
    } catch (e){
      debugPrint('[ERROR] searchLocation $e');
      rethrow;
    }
  }
  Future<WeatherCurrentResponse?> getWeatherByLatLng(num lat, num lng) async {
    try{
      return await client.dio.get(
        'current.json',
        queryParameters: {'q': '$lat,$lng'},
      ).then((res) {
        if(res.statusCode == HttpStatus.ok){
          return WeatherCurrentResponse.fromJson(res.data);
        }
        return null;
      });
    } catch (e){
      debugPrint('[ERROR] getCurrentWeather $e');
      rethrow;
    }
  }
}