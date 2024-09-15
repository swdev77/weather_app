import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:weather_app_tdd_cleanarch/city_weather/data/data_sources/remote_data_source.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/data/models/weather_model.dart';
import 'package:weather_app_tdd_cleanarch/core/constants.dart';
import 'package:weather_app_tdd_cleanarch/core/errors/exception.dart';

import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSourceImpl = WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const cityName = 'London';

  group(
    'get current weather',
    () {
      test(
        'should return weather model when the response code is 200',
        () async {
          // arrange
          when(
            mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(cityName))),
          ).thenAnswer(
            (_) async => http.Response(
              readJson('helpers/dummy_data/dummy_weather_response.json'),
              200,
            ),
          );

          // act
          final result = await remoteDataSourceImpl.getCurrentWeather(cityName);

          // assert
          expect(result, isA<WeatherModel>());
        },
      );

      test(
        'should throw a server exception when response code is 404 or other',
        () async {
          // arrange

          when(
            mockHttpClient.get(
              Uri.parse(Urls.currentWeatherByName(cityName)),
            ),
          ).thenAnswer(
            (_) async => http.Response('Not Found', 404),
          );

          // assert
          expect(
            () async => await remoteDataSourceImpl.getCurrentWeather(cityName),
            throwsA(isA<ServerException>()),
          );
        },
      );
    },
  );
}
