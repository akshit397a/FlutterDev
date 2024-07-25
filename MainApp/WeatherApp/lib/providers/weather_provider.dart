import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/weather.dart';
import '../models/weather.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  List<Weather> _forecast = [];
  bool _isLoading = false;
  String? _error;

  Weather? get weather => _weather;
  List<Weather> get forecast => _forecast;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=02a8fcb79ed2b6abe9fb1fd0acaa878a'));
      if (response.statusCode == 200) {
        _weather = Weather.fromJson(json.decode(response.body));
        _forecast = await fetchForecast(city);
      } else {
        _error = 'City not found';
      }
    } catch (e) {
      _error = 'An error occurred';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<List<Weather>> fetchForecast(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=02a8fcb79ed2b6abe9fb1fd0acaa878a'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['list'];
      return data.map((item) => Weather.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}
