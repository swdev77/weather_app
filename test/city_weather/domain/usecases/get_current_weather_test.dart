import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/domain/entities/weather.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/domain/usecases/get_current_weather.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeather getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase =
        GetCurrentWeather(repository: mockWeatherRepository);
  });

  const cityName = 'Tashkent';

  const weather = WeatherEntity(
    cityName: cityName,
    main: 'Clear',
    description: 'Sunny',
    iconCode: '01d',
    temperature: 20,
    pressure: 1000,
    humidity: 60,
  );

  test(
    'should get current weather from the repository',
    () async {
      // arrange

      when(
        mockWeatherRepository.getCurrentWeather(cityName),
      ).thenAnswer(
        (_) async => const Right(weather),
      );

      // act
      final result = await getCurrentWeatherUseCase.execute(cityName);

      // assert
      expect(result, const Right(weather));
    },
  );
}
