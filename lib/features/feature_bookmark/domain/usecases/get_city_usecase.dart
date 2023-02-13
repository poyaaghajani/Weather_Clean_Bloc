import 'package:weather/core/resorses/data_state.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/domain/repository/city_repository.dart';

class GetCityUsecase implements Usecase<DataState<City?>, String> {
  final CityRepository cityRepository;

  GetCityUsecase(this.cityRepository);
  @override
  Future<DataState<City?>> call(String params) {
    return cityRepository.findCityByName(params);
  }
}
