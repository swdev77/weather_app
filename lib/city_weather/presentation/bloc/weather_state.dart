import 'package:equatable/equatable.dart';

import '../../domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity weather;

  const WeatherLoaded({required this.weather});

  @override
  List<Object?> get props => [weather];
}

class WeatherLoadFailure extends WeatherState {
  final String message;

  const WeatherLoadFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
