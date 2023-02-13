import 'package:weather/core/resorses/data_state.dart';
import 'package:weather/features/feature_bookmark/data/datasource/local/city_dao.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/domain/repository/city_repository.dart';

class CityRepositoryImpl extends CityRepository {
  CityDao cityDao;
  CityRepositoryImpl(this.cityDao);

  @override
  Future<DataState<City>> saveCityToDB(String cityName) async {
    try {
      City? checkCity = await cityDao.findCityByName(cityName);
      if (checkCity != null) {
        return DataFailed('$cityName has already exist');
      }
      City city = City(name: cityName);
      await cityDao.insertCity(city);
      return DataSuccess(city);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<City>>> gettAllCityFromDB() async {
    try {
      List<City> cities = await cityDao.getAllCity();
      return DataSuccess(cities);
    } catch (e) {
      return DataFailed(
        e.toString(),
      );
    }
  }

  @override
  Future<DataState<City?>> findCityByName(String name) async {
    try {
      City? city = await cityDao.findCityByName(name);
      return DataSuccess(city);
    } catch (e) {
      return DataFailed(
        e.toString(),
      );
    }
  }

  @override
  Future<DataState<String>> deletCityByName(String name) async {
    try {
      await cityDao.deletCityByName(name);
      return DataSuccess(name);
    } catch (e) {
      return DataFailed(
        e.toString(),
      );
    }
  }
}
