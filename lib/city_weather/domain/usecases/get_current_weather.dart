import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather({required this.repository});

  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return repository.getCurrentWeather(cityName);
  }
}