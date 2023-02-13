part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkEvent {}

// get all city --> bookmark screen
class GetAllCityEvent extends BookmarkEvent {}

// finh city --> home screen
class GetCityByNameEvent extends BookmarkEvent {
  final String cityName;
  GetCityByNameEvent(this.cityName);
}

// save city in bookmark screen --> home screen
class SaveCwEvent extends BookmarkEvent {
  final String name;
  SaveCwEvent(this.name);
}

// return star icon to initial state after adding a city --> home screen
class SaveCityInitialEvent extends BookmarkEvent {}

// delet a city in bookmark screen --> bookmark screen
class DeleteCityEvent extends BookmarkEvent {
  final String name;
  DeleteCityEvent(this.name);
}
