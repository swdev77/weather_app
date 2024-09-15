import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/data/models/weather_model.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/domain/entities/weather.dart';

import '../../../helpers/json_reader.dart';

void main() {
  const weatherModel = WeatherModel(
    cityName: 'London',
    main: 'Clouds',
    description: 'overcast clouds',
    iconCode: '04d',
    temperature: 291.48,
    pressure: 1025,
    humidity: 64,
  );
  test('should be subclass of weather entity', () async {
    expect(weatherModel, isA<WeatherEntity>());
  });

  test('should return valid model from json', () async {
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_weather_response.json'));

    final result = WeatherModel.fromJson(jsonMap);

    expect(result, equals(weatherModel));
  });

  test('should return a json map containing proper data', () async {
    final result = weatherModel.toJson();

    final expectedJsonMap = {
      'weather': [
        {
          'main': 'Clouds',
          'description': 'overcast clouds',
          'icon': '04d',
        },
      ],
      'main': {
        'temp': 291.48,
        'pressure': 1025,
        'humidity': 64,
      },
      'name': 'London',
    };

    expect(result, equals(expectedJsonMap));
  });
}
