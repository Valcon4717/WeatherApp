import 'package:flutter/material.dart';
import '../model/weatherModel.dart';
import '../service/weatherService.dart';
import 'dart:developer' as developer;

class WeatherController extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weather;
  bool _isLoading = true;

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;

  Future<void> loadWeather() async {
    try {
      _isLoading = true;
      notifyListeners();

      _weather = await _weatherService.fetchWeather();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      developer.log('Error fetching weather',
          name: 'weatherController', error: e);
      _isLoading = false;
      notifyListeners();
    }
  }
}
