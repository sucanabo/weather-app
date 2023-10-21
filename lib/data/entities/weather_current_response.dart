import 'package:weather_app/utils/extensions.dart';

class WeatherCurrentResponse {
  final Location? location;
  final Current? current;

  WeatherCurrentResponse({
    this.location,
    this.current,
  });

  factory WeatherCurrentResponse.fromJson(Map<String, dynamic> json) => WeatherCurrentResponse(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    current: json["current"] == null ? null : Current.fromJson(json["current"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "current": current?.toJson(),
  };
}

class Current {
  final num? lastUpdatedEpoch;
  final String? lastUpdated;
  final double? tempC;
  final double? tempF;
  final num? isDay;
  final Condition? condition;
  final double? windMph;
  final double? windKph;
  final num? windDegree;
  final String? windDir;
  final num? pressureMb;
  final double? pressureIn;
  final num? precipMm;
  final num? precipIn;
  final num? humidity;
  final num? cloud;
  final double? feelslikeC;
  final double? feelslikeF;
  final num? visKm;
  final num? visMiles;
  final num? uv;
  final double? gustMph;
  final double? gustKph;

  Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    lastUpdatedEpoch: json["last_updated_epoch"],
    lastUpdated: json["last_updated"],
    tempC: json["temp_c"],
    tempF: json["temp_f"],
    isDay: json["is_day"],
    condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
    windMph: json["wind_mph"]?.toDouble(),
    windKph: json["wind_kph"]?.toDouble(),
    windDegree: json["wind_degree"],
    windDir: json["wind_dir"],
    pressureMb: json["pressure_mb"],
    pressureIn: json["pressure_in"]?.toDouble(),
    precipMm: json["precip_mm"],
    precipIn: json["precip_in"],
    humidity: json["humidity"],
    cloud: json["cloud"],
    feelslikeC: json["feelslike_c"]?.toDouble(),
    feelslikeF: json["feelslike_f"]?.toDouble(),
    visKm: json["vis_km"],
    visMiles: json["vis_miles"],
    uv: json["uv"],
    gustMph: json["gust_mph"]?.toDouble(),
    gustKph: json["gust_kph"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "last_updated_epoch": lastUpdatedEpoch,
    "last_updated": lastUpdated,
    "temp_c": tempC,
    "temp_f": tempF,
    "is_day": isDay,
    "condition": condition?.toJson(),
    "wind_mph": windMph,
    "wind_kph": windKph,
    "wind_degree": windDegree,
    "wind_dir": windDir,
    "pressure_mb": pressureMb,
    "pressure_in": pressureIn,
    "precip_mm": precipMm,
    "precip_in": precipIn,
    "humidity": humidity,
    "cloud": cloud,
    "feelslike_c": feelslikeC,
    "feelslike_f": feelslikeF,
    "vis_km": visKm,
    "vis_miles": visMiles,
    "uv": uv,
    "gust_mph": gustMph,
    "gust_kph": gustKph,
  };
}

class Condition {
  final String? text;
  final String? icon;
  final num? code;

  Condition({
    this.text,
    this.icon,
    this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    text: json["text"],
    icon: json["icon"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "icon": icon,
    "code": code,
  };
}

class Location {
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final String? tzId;
  final num? localtimeEpoch;
  final DateTime? localtime;

  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
    region: json["region"],
    country: json["country"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    tzId: json["tz_id"],
    localtimeEpoch: json["localtime_epoch"],
    localtime: json["localtime"].dateTimeOrNull,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "region": region,
    "country": country,
    "lat": lat,
    "lon": lon,
    "tz_id": tzId,
    "localtime_epoch": localtimeEpoch,
    "localtime": localtime,
  };
}
