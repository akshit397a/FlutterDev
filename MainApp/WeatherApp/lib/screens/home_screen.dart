import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/providers/weather_provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: Consumer<WeatherProvider>(
          builder: (context, weatherProvider, child) {
            if (weatherProvider.isLoading) {
              return const CircularProgressIndicator();
            }

            if (weatherProvider.error != null) {
              return Text(
                'Error: ${weatherProvider.error}',
                style: const TextStyle(color: Colors.red, fontSize: 20),
              );
            }

            if (weatherProvider.weather == null) {
              return const Text('Enter a city to get the weather');
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WeatherCard(weather: weatherProvider.weather!),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: weatherProvider.forecast.length,
                    itemBuilder: (context, index) {
                      return WeatherCard(weather: weatherProvider.forecast[index]);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final city = await _showCityInputDialog(context);
          if (city != null) {
            // ignore: use_build_context_synchronously
            context.read<WeatherProvider>().fetchWeather(city);
          }
        },
        child: const Icon(Icons.search),
      ),
    );
  }

  Future<String?> _showCityInputDialog(BuildContext context) async {
    String city = '';
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter city name'),
          content: TextField(
            onChanged: (value) => city = value,
            decoration: const InputDecoration(hintText: 'City name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(city),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
