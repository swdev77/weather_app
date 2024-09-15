import 'package:mockito/annotations.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/data/data_sources/remote_data_source.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  WeatherRepository,
  WeatherRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])

void main() {}