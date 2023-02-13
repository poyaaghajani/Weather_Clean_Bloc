// crate an abstract class for all usecases

// get a params and returnes a type
abstract class Usecase<T, P> {
  Future<T> call(P params);
}

// use this class when you dont wanna send any params
class NoParams {}
