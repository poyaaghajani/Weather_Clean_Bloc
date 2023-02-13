import 'package:flutter/cupertino.dart';
import 'package:weather/features/feature_weather/domain/entities/current_city_entity.dart';

// create an status class for handle current weather screen statuses

@immutable
abstract class CwStatus {}

class CwLoading extends CwStatus {}

class CwCompleted extends CwStatus {
  final CurrentCityEntity currentCityEntity;
  CwCompleted(this.currentCityEntity);
}

class CwError extends CwStatus {
  final Text message;
  CwError(this.message);
}
