// To parse this JSON data, do
//
//     final weatherSearchResponse = weatherSearchResponseFromJson(jsonString);

import 'dart:convert';

LocationSearchResponse weatherSearchResponseFromJson(String str) => LocationSearchResponse.fromJson(json.decode(str));

String weatherSearchResponseToJson(LocationSearchResponse data) => json.encode(data.toJson());

class LocationSearchResponse {
  final int? id;
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final String? url;

  LocationSearchResponse({
    this.id,
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.url,
  });

  factory LocationSearchResponse.fromJson(Map<String, dynamic> json) => LocationSearchResponse(
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
