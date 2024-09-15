import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/domain/entities/weather.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/domain/repositories/weather_repository.dart';
import 'package:weather_app_tdd_cleanarch/core/errors/exception.dart';
import 'package:weather_app_tdd_cleanarch/core/errors/failure.dart';
import '../data_sources/remote_data_source.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
