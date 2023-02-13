import 'package:weather/core/resorses/data_state.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';

abstract class CityRepository {
  Future<DataState<City>> saveCityToDB(String cityName);

  Future<DataState<List<City>>> gettAllCityFromDB();

  Future<DataState<City?>> findCityByName(String name);

  Future<DataState<String>> deletCityByName(String name);
}
