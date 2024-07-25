import 'package:flutter/material.dart';
import '../models/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({required this.weather, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Image.network(
          'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
          width: 50,
          height: 50,
        ),
        title: Text(
          '${weather.temperature}°C',
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Text(weather.description),
        trailing: Text(
          '${weather.date.hour}:00',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
