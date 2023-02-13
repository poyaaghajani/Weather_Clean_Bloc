import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repositort.dart';

class GetSuggestionCityUsecase implements Usecase<List<Data>, String> {
  final WeatherRepository _weatherRepository;
  GetSuggestionCityUsecase(this._weatherRepository);

  @override
  Future<List<Data>> call(String params) {
    return _weatherRepository.fetchSuggestionData(params);
  }
}
