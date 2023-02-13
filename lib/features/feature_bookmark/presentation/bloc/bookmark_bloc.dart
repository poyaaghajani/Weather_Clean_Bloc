import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/resorses/data_state.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/dele_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/gat_all_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/get_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/save_city_usecase.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/delet_city_status.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/get_all_city_status.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/get_city_status.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/save_city_status.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  SaveCityUsecase saveCityUsecase;
  GetCityUsecase getCityUsecase;
  GetAllCityUseCase getAllCityUseCase;
  DeleteCityUseCase deleteCityUseCase;

  BookmarkBloc(
    this.getCityUsecase,
    this.saveCityUsecase,
    this.getAllCityUseCase,
    this.deleteCityUseCase,
  ) : super(
          BookmarkState(
            getCityStatus: GetCityLoading(),
            saveCityStatus: SaveCityInitial(),
            getAllCityStatus: GetAllCityLoading(),
            deletCityStatus: DeletCityInitial(),
          ),
        ) {
    on<DeleteCityEvent>((event, emit) async {
      /// emit Loading state
      emit(state.copyWith(newDeleteCityStatus: DeletCityLoading()));

      final DataState dataState = await deleteCityUseCase(event.name);

      /// emit Complete state
      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newDeleteCityStatus: DeletCityCompleted(dataState.data.toString()),
          ),
        );
      }

      /// emit Error state
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newDeleteCityStatus: DeletCityError(dataState.error),
          ),
        );
      }
    });

    /// get All city
    on<GetAllCityEvent>((event, emit) async {
      /// emit Loading state
      emit(state.copyWith(newGetAllCityStatus: GetAllCityLoading()));

      final DataState dataState = await getAllCityUseCase(NoParams());

      /// emit Complete state
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetAllCityStatus: GetAllCityCompleted(dataState.data)));
      }

      /// emit Error state
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newGetAllCityStatus: GetAllCityError(dataState.error!),
          ),
        );
      }
    });
    on<GetCityByNameEvent>((event, emit) async {
      /// emit Loading state
      emit(state.copyWith(newGetCityStatus: GetCityLoading()));

      final DataState dataState = await getCityUsecase(event.cityName);

      /// emit Complete state
      if (dataState is DataSuccess) {
        emit(
            state.copyWith(newGetCityStatus: GetCityCompleted(dataState.data)));
      }

      /// emit Error state
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newGetCityStatus: GetCityError(dataState.error.toString()),
          ),
        );
      }
    });

    /// Save City Event
    on<SaveCwEvent>((event, emit) async {
      /// emit Loading state
      emit(state.copyWith(newSaveCityStatus: SaveCityLoading()));

      final DataState dataState = await saveCityUsecase(event.name);

      /// emit Complete state
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newSaveCityStatus: SaveCityCompleted(dataState.data)));
      }

      /// emit Error state
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newSaveCityStatus: SaveCityError(dataState.error.toString()),
          ),
        );
      }
    });

    /// set to init again SaveCity (برای بار دوم و سوم و غیره باید وضعیت دوباره به حالت اول برگرده وگرنه بوکمارک پر خواهد ماند)
    on<SaveCityInitialEvent>((event, emit) async {
      emit(state.copyWith(newSaveCityStatus: SaveCityInitial()));
    });
  }
}
