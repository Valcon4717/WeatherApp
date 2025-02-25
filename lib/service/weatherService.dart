import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/weatherModel.dart';

class WeatherService {
  final String apiUrl =
      "https://api.open-meteo.com/v1/forecast?latitude=31.9401&longitude=-106.4252&current=temperature_2m,is_day,weather_code&daily=weather_code&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&timezone=auto";

  Future<WeatherModel> fetchWeather() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }
}
