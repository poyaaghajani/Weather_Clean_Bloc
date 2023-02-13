part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  final SaveCityStatus saveCityStatus;
  final GetCityStatus getCityStatus;
  final GetAllCityStatus getAllCityStatus;
  final DeleteCityStatus deletCityStatus;

  const BookmarkState({
    required this.saveCityStatus,
    required this.getCityStatus,
    required this.getAllCityStatus,
    required this.deletCityStatus,
  });

  BookmarkState copyWith({
    SaveCityStatus? newSaveCityStatus,
    GetCityStatus? newGetCityStatus,
    GetAllCityStatus? newGetAllCityStatus,
    DeleteCityStatus? newDeleteCityStatus,
  }) {
    return BookmarkState(
      saveCityStatus: newSaveCityStatus ?? saveCityStatus,
      getCityStatus: newGetCityStatus ?? getCityStatus,
      getAllCityStatus: newGetAllCityStatus ?? getAllCityStatus,
      deletCityStatus: newDeleteCityStatus ?? deletCityStatus,
    );
  }

  @override
  List<Object?> get props => [
        saveCityStatus,
        getCityStatus,
        getAllCityStatus,
        deletCityStatus,
      ];
}
