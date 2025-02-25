import '../model/weatherModel.dart';
import '../service/weatherService.dart';

class WeatherController {
  final WeatherService _weatherService = WeatherService();
  WeatherModel? weather;
  bool isLoading = true;

  Future<void> loadWeather() async {
    try {
      weather = await _weatherService.fetchWeather();
      isLoading = false;
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }
}
