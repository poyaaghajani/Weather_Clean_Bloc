// error handeling class

abstract class DataState<T> {
  final T? data;
  final String? error;

  DataState(this.data, this.error);
}

// get data and send it for abstract class

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T? data) : super(data, null);
}

// get errorMessage and send it for abstract class

class DataFailed<T> extends DataState<T> {
  DataFailed(String error) : super(null, error);
}
