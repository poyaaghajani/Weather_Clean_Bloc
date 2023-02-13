import 'package:equatable/equatable.dart';

abstract class DeleteCityStatus extends Equatable {}

class DeletCityInitial extends DeleteCityStatus {
  @override
  List<Object?> get props => [];
}

class DeletCityLoading extends DeleteCityStatus {
  @override
  List<Object?> get props => [];
}

class DeletCityCompleted extends DeleteCityStatus {
  final String name;
  DeletCityCompleted(this.name);
  @override
  List<Object?> get props => [name];
}

class DeletCityError extends DeleteCityStatus {
  final String? message;
  DeletCityError(this.message);
  @override
  List<Object?> get props => [message];
}
