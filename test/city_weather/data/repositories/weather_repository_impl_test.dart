import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/data/models/weather_model.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/domain/entities/weather.dart';
import 'package:weather_app_tdd_cleanarch/core/errors/exception.dart';
import 'package:weather_app_tdd_cleanarch/core/errors/failure.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(
    () {
      mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
      weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource,
      );
    },
  );

  const cityName = 'London';

  const weatherModel = WeatherModel(
    cityName: 'London',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01d',
    temperature: 280.15,
    pressure: 1012,
    humidity: 70,
  );

  const weatherEntity = WeatherEntity(
    cityName: 'London',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01d',
    temperature: 280.15,
    pressure: 1012,
    humidity: 70,
  );

  group(
    'get current weather',
    () {
      test(
        'should return current weather when a call to data source is successful',
        () async {
          when(
            mockWeatherRemoteDataSource.getCurrentWeather(cityName),
          ).thenAnswer(
            (_) async => weatherModel,
          );

          final result =
              await weatherRepositoryImpl.getCurrentWeather(cityName);

          expect(result, equals(const Right(weatherEntity)));
        },
      );

      test(
        'should return server failure when a call to data source is unsuccessful',
        () async {
          when(
            mockWeatherRemoteDataSource.getCurrentWeather(cityName),
          ).thenThrow(
            ServerException(),
          );

          final result =
              await weatherRepositoryImpl.getCurrentWeather(cityName);

          expect(
              result, equals(const Left(ServerFailure('An error occurred'))));
        },
      );

      test(
        'should return connection failure when the device has no internet',
        () async {
          when(
            mockWeatherRemoteDataSource.getCurrentWeather(cityName),
          ).thenThrow(
            const SocketException('Failed to connect to the network'),
          );

          final result = await weatherRepositoryImpl.getCurrentWeather(cityName);

          expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
        },
      );
    },
  );
}
