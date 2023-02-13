import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/resorses/data_state.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repositort.dart';

class GetForecastWeatherUseCase
    implements Usecase<DataState<ForecastDaysEntity>, ForeCastParams> {
  final WeatherRepository _weatherRepository;
  GetForecastWeatherUseCase(this._weatherRepository);

  @override
  Future<DataState<ForecastDaysEntity>> call(ForeCastParams params) {
    return _weatherRepository.fetchForecastWeatherData(params);
  }
}
