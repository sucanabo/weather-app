import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/app/weather_api_client.dart';
import 'package:weather_app/data/weather_search_entity.dart';

class WeatherRepository {
  final WeatherAPIClient client;
  const WeatherRepository(this.client);
  
  Future<List<WeatherSearchResponse>> searchLocation(String searchString) async {
    try{
      return await client.dio.get<List<WeatherSearchResponse>>(
        'search.json',
        queryParameters: {'q': searchString},
      ).then((res) {
        if(res.statusCode == HttpStatus.ok){
         return res.data ?? [];
        }
        return [];
      });
    } catch (e){
      debugPrint('[ERROR] searchLocation $e');
      rethrow;
    }
  }
}