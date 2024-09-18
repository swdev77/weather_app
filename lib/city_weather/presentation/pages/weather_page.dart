import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Weather',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) {
                context.read<WeatherBloc>().add(
                      OnCityChanged(cityName: query),
                    );
              },
            ),
            const SizedBox(height: 32.0),

            // BlocBuilder is a widget that rebuilds when the state changes
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is WeatherLoaded) {
                  return Column(
                    key: const Key('weather_data'),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.weather.cityName,
                            style: const TextStyle(fontSize: 22.0),
                          ),
                          Image(
                            image: NetworkImage(
                                Urls.weatherIcon(state.weather.iconCode)),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                      Text(
                        '${state.weather.main} | ${state.weather.description}',
                        style:
                            const TextStyle(fontSize: 16.0, letterSpacing: 1.2),
                      ),
                      const SizedBox(height: 24.0),
                      Table(
                        defaultColumnWidth: const FixedColumnWidth(150.0),
                        border: TableBorder.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        children: [
                          TableRow(
                            children: [
                              const TableRowTitle(
                                title: 'Temperature',
                              ),
                              TableRowValue(
                                data: state.weather.temperature.toString(),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const TableRowTitle(
                                title: 'Pressure',
                              ),
                              TableRowValue(
                                data: state.weather.pressure.toString(),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const TableRowTitle(
                                title: 'Humidity',
                              ),
                              TableRowValue(
                                data: state.weather.humidity.toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }

                if (state is WeatherLoadFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TableRowValue extends StatelessWidget {
  const TableRowValue({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        data,
        style: const TextStyle(
          fontSize: 16.0,
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TableRowTitle extends StatelessWidget {
  const TableRowTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
