import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/domain/entities/weather.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/presentation/bloc/weather_event.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/presentation/bloc/weather_state.dart';
import 'package:weather_app_tdd_cleanarch/core/errors/failure.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeather mockGetCurrentWeather;
  late WeatherBloc weatherBloc;

  setUp(
    () {
      mockGetCurrentWeather = MockGetCurrentWeather();
      weatherBloc = WeatherBloc(getCurrentWeather: mockGetCurrentWeather);
    },
  );

  const weatherEntity = WeatherEntity(
    cityName: 'Tashkent',
    main: 'Clear',
    description: 'Sunny',
    iconCode: '01d',
    temperature: 20,
    pressure: 1000,
    humidity: 60,
  );

  const cityName = 'Tashkent';

  test(
    'initial state should be empty',
    () {
      expect(weatherBloc.state, equals(WeatherEmpty()));
    },
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
    build: () {
      when(
        mockGetCurrentWeather.execute(cityName),
      ).thenAnswer(
        (_) async => const Right(weatherEntity),
      );
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(cityName: cityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(weather: weatherEntity),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoadFailure] when get data is unsuccessful',
    build: () {
      when(
        mockGetCurrentWeather.execute(cityName),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(cityName: cityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoadFailure(message: 'Server Failure'),
    ],
  );
}
