import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_days_entity.dart';

// handle our forecast days statuses
@immutable
abstract class FwStatus extends Equatable {}

/// loading state
class FwLoading extends FwStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class FwCompleted extends FwStatus {
  final ForecastDaysEntity forecastDaysEntity;
  FwCompleted(this.forecastDaysEntity);

  @override
  List<Object?> get props => [forecastDaysEntity];
}

/// error state
class FwError extends FwStatus {
  final Text? message;
  FwError(this.message);

  @override
  List<Object?> get props => [message];
}
