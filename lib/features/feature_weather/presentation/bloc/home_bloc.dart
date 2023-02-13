import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/resorses/data_state.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_forecast_days_usecase.dart';
import 'package:weather/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/fw_status.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrectWeatherUsecase getCurrentWeatherUseCase;
  final GetForecastWeatherUseCase _getForecastWeatherUseCase;

  HomeBloc(this.getCurrentWeatherUseCase, this._getForecastWeatherUseCase)
      : super(HomeState(cwStatus: CwLoading(), fwStatus: FwLoading())) {
    on<LoadCwEvent>((event, emit) async {
      emit(state.copyWith(newCwStatus: CwLoading()));

      DataState dataState = await getCurrentWeatherUseCase(event.cityName);

      if (dataState is DataSuccess) {
        emit(state.copyWith(newCwStatus: CwCompleted(dataState.data)));
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newCwStatus: CwError(Text(dataState.error.toString())),
          ),
        );
      }
    });

    /// load 7 days Forecast weather for city Event
    on<LoadFwEvent>((event, emit) async {
      /// emit State to Loading for just Fw
      emit(state.copyWith(newFwStatus: FwLoading()));

      final DataState dataState =
          await _getForecastWeatherUseCase(event.forecastParams);

      /// emit State to Completed for just Fw
      if (dataState is DataSuccess) {
        emit(state.copyWith(newFwStatus: FwCompleted(dataState.data)));
      }

      /// emit State to Error for just Fw
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newFwStatus: FwError(Text(dataState.error.toString())),
          ),
        );
      }
    });
  }
}
