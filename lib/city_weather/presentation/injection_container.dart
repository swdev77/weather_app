import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../data/data_sources/remote_data_source.dart';
import '../data/repositories/weather_repository_impl.dart';
import '../domain/repositories/weather_repository.dart';
import '../domain/usecases/get_current_weather.dart';
import 'bloc/weather_bloc.dart';

final locator = GetIt.instance;

void setUpLocator() {
  // Bloc
  locator.registerFactory(
    () => WeatherBloc(getCurrentWeather: locator()),
  );

  // Use cases
  locator.registerLazySingleton(
    () => GetCurrentWeather(repository: locator()),
  );

  // Repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()),
  );

  // Data sources
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(client: locator()),
  );

  // External
  locator.registerLazySingleton(() => http.Client());
}
