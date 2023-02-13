import 'package:weather/core/resorses/data_state.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/feature_bookmark/domain/repository/city_repository.dart';

class DeleteCityUseCase implements Usecase<DataState<String>, String> {
  final CityRepository _cityRepository;
  DeleteCityUseCase(this._cityRepository);

  @override
  Future<DataState<String>> call(String params) {
    return _cityRepository.deletCityByName(params);
  }
}
