import 'package:get_it/get_it.dart';
import 'package:weather/features/feature_bookmark/data/datasource/local/database.dart';
import 'package:weather/features/feature_bookmark/data/repository/city_repository_impl.dart';
import 'package:weather/features/feature_bookmark/domain/repository/city_repository.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/dele_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/gat_all_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/get_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/save_city_usecase.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:weather/features/feature_weather/data/datasource/remote/api_provider.dart';
import 'package:weather/features/feature_weather/data/repository/weather_repository_impl.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repositort.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_forecast_days_usecase.dart';
import 'package:weather/features/feature_weather/presentation/bloc/home_bloc.dart';

GetIt locator = GetIt.instance;

// this function is supposed to do dependency injection in whole project

setUp() async {
  locator.registerSingleton<ApiProvider>(ApiProvider());

  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  locator.registerSingleton<AppDatabase>(database);

  // repositories
  locator
      .registerSingleton<WeatherRepository>(WeatherRepositoryImpl(locator()));
  locator
      .registerSingleton<CityRepository>(CityRepositoryImpl(database.cityDao));

  // usecases
  locator.registerSingleton<GetCurrectWeatherUsecase>(
    GetCurrectWeatherUsecase(locator()),
  );
  locator.registerSingleton<GetForecastWeatherUseCase>(
    GetForecastWeatherUseCase(locator()),
  );
  locator.registerSingleton<GetCityUsecase>(GetCityUsecase(locator()));
  locator.registerSingleton<SaveCityUsecase>(SaveCityUsecase(locator()));
  locator.registerSingleton<GetAllCityUseCase>(GetAllCityUseCase(locator()));
  locator.registerSingleton<DeleteCityUseCase>(DeleteCityUseCase(locator()));

  // homeBloc
  locator.registerSingleton<HomeBloc>(HomeBloc(locator(), locator()));
  locator.registerSingleton<BookmarkBloc>(
    BookmarkBloc(locator(), locator(), locator(), locator()),
  );
}
