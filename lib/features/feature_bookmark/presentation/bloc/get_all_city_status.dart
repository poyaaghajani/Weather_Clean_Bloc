import 'package:equatable/equatable.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';

abstract class GetAllCityStatus extends Equatable {}

class GetAllCityLoading extends GetAllCityStatus {
  @override
  List<Object?> get props => [];
}

class GetAllCityCompleted extends GetAllCityStatus {
  final List<City> cities;
  GetAllCityCompleted(this.cities);
  @override
  List<Object?> get props => [cities];
}

class GetAllCityError extends GetAllCityStatus {
  final String message;
  GetAllCityError(this.message);
  @override
  List<Object?> get props => [message];
}
