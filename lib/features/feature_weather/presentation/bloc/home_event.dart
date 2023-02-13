part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class LoadCwEvent extends HomeEvent {
  final String cityName;
  LoadCwEvent(this.cityName);
}

class LoadFwEvent extends HomeEvent {
  final ForeCastParams forecastParams;
  LoadFwEvent(this.forecastParams);
}
