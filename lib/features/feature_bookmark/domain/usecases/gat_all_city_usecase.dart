import 'package:weather/core/resorses/data_state.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/domain/repository/city_repository.dart';

class GetAllCityUseCase implements Usecase<DataState<List<City>>, NoParams> {
  final CityRepository _cityRepository;
  GetAllCityUseCase(this._cityRepository);

  @override
  Future<DataState<List<City>>> call(NoParams params) {
    return _cityRepository.gettAllCityFromDB();
  }
}
