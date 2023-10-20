import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
const String baseUrl = "https://weatherapi-com.p.rapidapi.com/";
const String apiKey = "b8e0a01cc8msh2e734f85422eb4bp1bdb6ajsn3d44dcd11fc8";
const String apiHost = "weatherapi-com.p.rapidapi.com";
const int _kReceiveTimeout = 15000;
const int _kSendTimeout = 15000;
const int _kConnectTimeout = 15000;

class WeatherAPIClient {
  static late final Dio dio;

  WeatherAPIClient._() {
    dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          contentType: 'application/json',
          headers: {
            'X-RapidAPI-Key': apiKey,
            'X-RapidAPI-Host': apiHost,
          },
        connectTimeout: const Duration(milliseconds: _kConnectTimeout),
        sendTimeout: const Duration(milliseconds: _kSendTimeout),
        receiveTimeout: const Duration(milliseconds: _kReceiveTimeout),
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        request: true,
        error: true,
      ));
    }
  }
}
