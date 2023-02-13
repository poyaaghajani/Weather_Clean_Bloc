import 'package:weather/core/resorses/data_state.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repositort.dart';

class GetCurrectWeatherUsecase
    extends Usecase<DataState<CurrentCityEntity>, String> {
  final WeatherRepository weatherRepository;

  GetCurrectWeatherUsecase(this.weatherRepository);

  //callable class
  @override
  Future<DataState<CurrentCityEntity>> call(String params) {
    return weatherRepository.fetchCurrentWeatherData(params);
  }
}
