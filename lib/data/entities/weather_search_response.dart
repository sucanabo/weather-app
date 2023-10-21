// To parse this JSON data, do
//
//     final weatherSearchResponse = weatherSearchResponseFromJson(jsonString);

import 'dart:convert';

WeatherSearchResponse weatherSearchResponseFromJson(String str) => WeatherSearchResponse.fromJson(json.decode(str));

String weatherSearchResponseToJson(WeatherSearchResponse data) => json.encode(data.toJson());

class WeatherSearchResponse {
  final int? id;
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final String? url;

  WeatherSearchResponse({
    this.id,
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.url,
  });

  factory WeatherSearchResponse.fromJson(Map<String, dynamic> json) => WeatherSearchResponse(
    id: json["id"],
    name: json["name"],
    region: json["region"],
    country: json["country"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "region": region,
    "country": country,
    "lat": lat,
    "lon": lon,
    "url": url,
  };
}
