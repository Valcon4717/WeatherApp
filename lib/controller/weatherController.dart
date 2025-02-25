import '../model/weatherModel.dart';
import '../service/weatherService.dart';
import 'dart:developer' as developer;

class WeatherController {
  final WeatherService _weatherService = WeatherService();
  WeatherModel? weather;
  bool isLoading = true;

  Future<void> loadWeather() async {
    try {
      weather = await _weatherService.fetchWeather();
      isLoading = false;
    } catch (e) {
      developer.log('Error fetching weather in',
          name: 'weatherController: ', error: e);
    }
  }

  String categorizeWeatherCode(int code) {
    const Map<String, Set<int>> weatherCategories = {
      "Clear Sky": {0},
      "Partly Cloudy": {1, 2, 3},
      "Fog": {45, 48},
      "Rain": {51, 53, 55, 56, 57, 61, 63, 65, 66, 67, 80, 81, 82, 95, 96, 99},
      "Snow": {71, 73, 75, 77, 85, 86},
    };

    for (var entry in weatherCategories.entries) {
      if (entry.value.contains(code)) {
        return entry.key;
      }
    }
    return "Unknown Weather Code";
  }
}
