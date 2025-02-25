class WeatherModel {
  final double temperature;
  final bool isDay;
  final int weatherCode;
  final List<int> dailyWeatherCodes;

  WeatherModel({
    required this.temperature,
    required this.isDay,
    required this.weatherCode,
    required this.dailyWeatherCodes,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json['current']['temperature_2m'].toDouble(),
      isDay: json['current']['is_day'] == 1,
      weatherCode: json['current']['weather_code'],
      dailyWeatherCodes: List<int>.from(json['daily']['weather_code']),
    );
  }
}
