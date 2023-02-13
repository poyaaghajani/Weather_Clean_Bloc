import 'package:dio/dio.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/utils/constants.dart';

class ApiProvider {
  final Dio _dio = Dio();
  var apiKey = Constants.apiKey;

  /// current weather api call
  Future<dynamic> callCurrentWeather(cityName) async {
    var response = await _dio.get('${Constants.baseUrl}/data/2.5/weather',
        queryParameters: {'q': cityName, 'appid': apiKey, 'units': 'metric'});
    return response;
  }

  /// 7 days forecast api
  Future<dynamic> call7DaysForcastWeather(ForeCastParams params) async {
    var response = await _dio
        .get("${Constants.baseUrl}/data/2.5/onecall", queryParameters: {
      'lat': params.lat,
      'lon': params.lon,
      'exclude': 'minutely,hourly',
      'appid': apiKey,
      'units': 'metric'
    });

    return response;
  }

  // suggestion city name
  Future<dynamic> callCitySuggestion(String prefix) async {
    var response = await _dio.get(
      "http://geodb-free-service.wirefreethought.com/v1/geo/cities",
      queryParameters: {
        'limit': 7,
        'offset': 0,
        'namePrefix': prefix,
      },
    );
    return response;
  }
}
