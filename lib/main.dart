import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_tdd_cleanarch/city_weather/presentation/bloc/weather_bloc.dart';
import 'city_weather/presentation/injection_container.dart';
import 'city_weather/presentation/pages/weather_page.dart';

void main() {
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<WeatherBloc>(),
        )
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: WeatherPage(),
      ),
    );
  }
}
