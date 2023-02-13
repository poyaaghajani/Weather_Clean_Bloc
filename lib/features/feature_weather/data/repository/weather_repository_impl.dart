import 'package:dio/dio.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/resorses/data_state.dart';
import 'package:weather/features/feature_weather/data/datasource/remote/api_provider.dart';
import 'package:weather/features/feature_weather/data/models/current_city_model.dart';
import 'package:weather/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:weather/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:weather/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:weather/features/feature_weather/domain/entities/suggest_city_entity.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repositort.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  ApiProvider apiProvider;

  WeatherRepositoryImpl(this.apiProvider);

  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(
      String cityName) async {
    try {
      Response response = await apiProvider.callCurrentWeather(cityName);
      if (response.statusCode == 200) {
        CurrentCityEntity currentCityEntity =
            CurrentCityModel.fromJson(response.data);

        return DataSuccess(currentCityEntity);
      } else {
        return DataFailed(
          "Something Went Wrong. try again...",
        );
      }
    } catch (e) {
      return DataFailed(
        "please check your connection...",
      );
    }
  }

  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
      ForeCastParams params) async {
    try {
      Response response = await apiProvider.call7DaysForcastWeather(params);

      if (response.statusCode == 200) {
        ForecastDaysEntity forecastDaysEntity =
            ForecastDaysModel.fromJson(response.data);
        return DataSuccess(forecastDaysEntity);
      } else {
        return DataFailed(
          "Something Went Wrong. try again...",
        );
      }
    } catch (e) {
      return DataFailed(
        "please check your connection...",
      );
    }
  }

  @override
  Future<List<Data>> fetchSuggestionData(cityName) async {
    Response response = await apiProvider.callCitySuggestion(cityName);

    SuggestCityEntity suggestCityEntity =
        SuggestCityModel.fromJson(response.data);

    return suggestCityEntity.data!;
  }
}
