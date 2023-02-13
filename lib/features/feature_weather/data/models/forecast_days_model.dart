import 'package:weather/features/feature_weather/domain/entities/forecast_days_entity.dart';

class ForecastDaysModel extends ForecastDaysEntity {
  ForecastDaysModel({
    double? lat,
    double? lon,
    String? timezone,
    int? timezoneOffset,
    Current? current,
    List<Daily>? daily,
    List<Alerts>? alerts,
  }) : super(
          lat: lat,
          lon: lon,
          timezone: timezone,
          timezoneOffset: timezoneOffset,
          current: current,
          daily: daily,
          alerts: alerts,
        );

  factory ForecastDaysModel.fromJson(Map<String, dynamic> json) {
    /// convert daily from json
    final List<Daily> daily = [];
    if (json['daily'] != null) {
      json['daily'].forEach((v) {
        daily.add(Daily.fromJson(v));
      });
    }

    /// convert alerts from json
    final List<Alerts> alerts = [];
    if (json['alerts'] != null) {
      json['alerts'].forEach((v) {
        alerts.add(Alerts.fromJson(v));
      });
    }

    return ForecastDaysModel(
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      current:
          json['current'] != null ? Current.fromJson(json['current']) : null,
      daily: daily,
      alerts: alerts,
    );
  }
}

/// sender_name : ""
/// event : "Thunderstorms"
/// start : 1654408800
/// end : 1654452000
/// description : ""
/// tags : ["Thunderstorm"]
class Alerts {
  Alerts({
    String? senderName,
    String? event,
    int? start,
    int? end,
    String? description,
    List<String>? tags,
  }) {
    _senderName = senderName;
    _event = event;
    _start = start;
    _end = end;
    _description = description;
    _tags = tags;
  }

  Alerts.fromJson(dynamic json) {
    _senderName = json['sender_name'];
    _event = json['event'];
    _start = json['start'];
    _end = json['end'];
    _description = json['description'];
    _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
  }
  String? _senderName;
  String? _event;
  int? _start;
  int? _end;
  String? _description;
  List<String>? _tags;

  String? get senderName => _senderName;
  String? get event => _event;
  int? get start => _start;
  int? get end => _end;
  String? get description => _description;
  List<String>? get tags => _tags;
}

/// dt : 1654419600
/// sunrise : 1654392221
/// sunset : 1654451279
/// moonrise : 1654410000
/// moonset : 1654379580
/// moon_phase : 0.18
/// temp : {"day":20.35,"min":11.73,"max":20.73,"night":12.1,"eve":17.87,"morn":15.13}
/// feels_like : {"day":20.09,"night":11.72,"eve":17.72,"morn":14.76}
/// pressure : 1017
/// humidity : 63
/// dew_point : 13.08
/// wind_speed : 4.41
/// wind_deg : 2
/// wind_gust : 5.18
/// weather : [{"id":500,"main":"Rain","description":"light rain","icon":"10d"}]
/// clouds : 99
/// pop : 0.73
/// rain : 0.95
/// uvi : 5.32
class Daily {
  Daily({
    int? dt,
    int? sunrise,
    int? sunset,
    int? moonrise,
    int? moonset,
    double? moonPhase,
    Temp? temp,
    Feels_like? feelsLike,
    int? pressure,
    int? humidity,
    double? dewPoint,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    List<Weather>? weather,
    int? clouds,
    double? pop,
    double? rain,
    double? uvi,
  }) {
    _dt = dt;
    _sunrise = sunrise;
    _sunset = sunset;
    _moonrise = moonrise;
    _moonset = moonset;
    _moonPhase = moonPhase;
    _temp = temp;
    _feelsLike = feelsLike;
    _pressure = pressure;
    _humidity = humidity;
    _dewPoint = dewPoint;
    _windSpeed = windSpeed;
    _windDeg = windDeg;
    _windGust = windGust;
    _weather = weather;
    _clouds = clouds;
    _pop = pop;
    _rain = rain;
    _uvi = uvi;
  }

  Daily.fromJson(dynamic json) {
    _dt = json['dt'];
    _sunrise = json['sunrise'];
    _sunset = json['sunset'];
    _moonrise = json['moonrise'];
    _moonset = json['moonset'];
    _moonPhase = json['moon_phase'].toDouble();
    _temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
    _feelsLike = json['feels_like'] != null
        ? Feels_like.fromJson(json['feels_like'])
        : null;

    _pressure = json['pressure'];

    _humidity = json['humidity'];
    _dewPoint = json['dew_point'].toDouble();

    _windSpeed = json['wind_speed'].toDouble();
    _windDeg = json['wind_deg'];
    _windGust = json['wind_gust'].toDouble();
    if (json['weather'] != null) {
      _weather = [];
      json['weather'].forEach((v) {
        _weather?.add(Weather.fromJson(v));
      });
    }
    _clouds = json['clouds'];
    // _pop = json['pop'].toDouble();
    // _rain = json['rain'].toDouble();
    // _uvi = json['uvi'].toDouble();
  }
  int? _dt;
  int? _sunrise;
  int? _sunset;
  int? _moonrise;
  int? _moonset;
  double? _moonPhase;
  Temp? _temp;
  Feels_like? _feelsLike;
  int? _pressure;
  int? _humidity;
  double? _dewPoint;
  double? _windSpeed;
  int? _windDeg;
  double? _windGust;
  List<Weather>? _weather;
  int? _clouds;
  double? _pop;
  double? _rain;
  double? _uvi;

  int? get dt => _dt;
  int? get sunrise => _sunrise;
  int? get sunset => _sunset;
  int? get moonrise => _moonrise;
  int? get moonset => _moonset;
  double? get moonPhase => _moonPhase;
  Temp? get temp => _temp;
  Feels_like? get feelsLike => _feelsLike;
  int? get pressure => _pressure;
  int? get humidity => _humidity;
  double? get dewPoint => _dewPoint;
  double? get windSpeed => _windSpeed;
  int? get windDeg => _windDeg;
  double? get windGust => _windGust;
  List<Weather>? get weather => _weather;
  int? get clouds => _clouds;
  double? get pop => _pop;
  double? get rain => _rain;
  double? get uvi => _uvi;
}

/// id : 500
/// main : "Rain"
/// description : "light rain"
/// icon : "10d"
class Weather {
  Weather({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) {
    _id = id;
    _main = main;
    _description = description;
    _icon = icon;
  }

  Weather.fromJson(dynamic json) {
    _id = json['id'];
    _main = json['main'];
    _description = json['description'];
    _icon = json['icon'];
  }
  int? _id;
  String? _main;
  String? _description;
  String? _icon;

  int? get id => _id;
  String? get main => _main;
  String? get description => _description;
  String? get icon => _icon;
}

/// day : 20.09
/// night : 11.72
/// eve : 17.72
/// morn : 14.76
class Feels_like {
  Feels_like({
    double? day,
    double? night,
    double? eve,
    double? morn,
  }) {
    _day = day;
    _night = night;
    _eve = eve;
    _morn = morn;
  }

  Feels_like.fromJson(dynamic json) {
    _day = json['day'].toDouble();
    _night = json['night'].toDouble();
    _eve = json['eve'].toDouble();
    _morn = json['morn'].toDouble();
  }
  double? _day;
  double? _night;
  double? _eve;
  double? _morn;

  double? get day => _day;
  double? get night => _night;
  double? get eve => _eve;
  double? get morn => _morn;
}

/// day : 20.35
/// min : 11.73
/// max : 20.73
/// night : 12.1
/// eve : 17.87
/// morn : 15.13
class Temp {
  Temp({
    double? day,
    double? min,
    double? max,
    double? night,
    double? eve,
    double? morn,
  }) {
    _day = day;
    _min = min;
    _max = max;
    _night = night;
    _eve = eve;
    _morn = morn;
  }

  Temp.fromJson(dynamic json) {
    _day = json['day'].toDouble();
    _min = json['min'].toDouble();
    _max = json['max'].toDouble();
    _night = json['night'].toDouble();
    _eve = json['eve'].toDouble();
    _morn = json['morn'].toDouble();
  }
  double? _day;
  double? _min;
  double? _max;
  double? _night;
  double? _eve;
  double? _morn;

  double? get day => _day;
  double? get min => _min;
  double? get max => _max;
  double? get night => _night;
  double? get eve => _eve;
  double? get morn => _morn;
}

/// dt : 1654413279
/// sunrise : 1654392221
/// sunset : 1654451279
/// temp : 20.73
/// feels_like : 20.58
/// pressure : 1017
/// humidity : 66
/// dew_point : 14.15
/// uvi : 3.4
/// clouds : 99
/// visibility : 10000
/// wind_speed : 1.84
/// wind_deg : 31
/// wind_gust : 2.13
/// weather : [{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}]
class Current {
  Current({
    int? dt,
    int? sunrise,
    int? sunset,
    double? temp,
    double? feelsLike,
    int? pressure,
    int? humidity,
    double? dewPoint,
    double? uvi,
    int? clouds,
    int? visibility,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    List<Weather>? weather,
  }) {
    _dt = dt;
    _sunrise = sunrise;
    _sunset = sunset;
    _temp = temp;
    _feelsLike = feelsLike;
    _pressure = pressure;
    _humidity = humidity;
    _dewPoint = dewPoint;
    _uvi = uvi;
    _clouds = clouds;
    _visibility = visibility;
    _windSpeed = windSpeed;
    _windDeg = windDeg;
    _windGust = windGust;
    _weather = weather;
  }

  Current.fromJson(dynamic json) {
    _dt = json['dt'];
    _sunrise = json['sunrise'];
    _sunset = json['sunset'];
    _temp = json['temp'].toDouble();
    _feelsLike = json['feels_like'].toDouble();

    _pressure = json['pressure'];
    _humidity = json['humidity'];
    _dewPoint = json['dew_point'].toDouble();
    _uvi = json['uvi'].toDouble();
    _clouds = json['clouds'];
    _visibility = json['visibility'];

    _windSpeed = json['wind_speed'].toDouble();
    _windDeg = json['wind_deg'];
    // _windGust = json['wind_gust'].toDouble() ?? 0;

    if (json['weather'] != null) {
      _weather = [];
      json['weather'].forEach((v) {
        _weather?.add(Weather.fromJson(v));
      });
    }
  }
  int? _dt;
  int? _sunrise;
  int? _sunset;
  double? _temp;
  double? _feelsLike;
  int? _pressure;
  int? _humidity;
  double? _dewPoint;
  double? _uvi;
  int? _clouds;
  int? _visibility;
  double? _windSpeed;
  int? _windDeg;
  double? _windGust;
  List<Weather>? _weather;

  int? get dt => _dt;
  int? get sunrise => _sunrise;
  int? get sunset => _sunset;
  double? get temp => _temp;
  double? get feelsLike => _feelsLike;
  int? get pressure => _pressure;
  int? get humidity => _humidity;
  double? get dewPoint => _dewPoint;
  double? get uvi => _uvi;
  int? get clouds => _clouds;
  int? get visibility => _visibility;
  double? get windSpeed => _windSpeed;
  int? get windDeg => _windDeg;
  double? get windGust => _windGust;
  List<Weather>? get weather => _weather;
}
