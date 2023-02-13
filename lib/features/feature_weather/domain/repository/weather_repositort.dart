import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/resorses/data_state.dart';
import 'package:weather/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:weather/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_days_entity.dart';

abstract class WeatherRepository {
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);

  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
      ForeCastParams params);

  Future<List<Data>> fetchSuggestionData(cityName);
}
