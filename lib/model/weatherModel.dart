class WeatherModel {
  final double temperature;
  final bool isDay;
  final int weatherCode;
  final List<int> dailyWeatherCodes;
  final List<String> dailyDates;
  final List<double> dailyTemperatures;

  WeatherModel({
    required this.temperature,
    required this.isDay,
    required this.weatherCode,
    required this.dailyWeatherCodes,
    required this.dailyDates,
    required this.dailyTemperatures,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json['current']['temperature_2m'].toDouble(),
      isDay: json['current']['is_day'] == 1,
      weatherCode: json['current']['weather_code'],
      dailyWeatherCodes: List<int>.from(json['daily']['weather_code']),
      dailyDates: List<String>.from(json['daily']['time']),
      dailyTemperatures: List<double>.from(json['daily']['temperature_2m_max']),
    );
  }

  // Map weather codes to descriptions
  String get weatherDescription => _getWeatherDescription(weatherCode);

  static String _getWeatherDescription(int code) {
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
    return "Unknown";
  }

  // Generate a list of daily weather descriptions
  List<DailyForecast> get weeklyForecast {
    List<DailyForecast> forecasts = [];
    for (int i = 0; i < dailyDates.length; i++) {
      forecasts.add(DailyForecast(
        day: _getDayOfWeek(dailyDates[i]),
        temperature: dailyTemperatures[i],
        weatherDescription: _getWeatherDescription(dailyWeatherCodes[i]),
      ));
    }
    return forecasts;
  }

  // Convert "2025-02-25" to "Tue"
  static String _getDayOfWeek(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][parsedDate.weekday % 7];
  }
}

class DailyForecast {
  final String day;
  final double temperature;
  final String weatherDescription;

  DailyForecast({
    required this.day,
    required this.temperature,
    required this.weatherDescription,
  });
}
