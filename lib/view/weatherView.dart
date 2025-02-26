import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/weatherController.dart';
import '../controller/themeController.dart';
import '../model/weatherModel.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: Icon(themeController.themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: themeController.toggleTheme,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Consumer<WeatherController>(
            builder: (context, weatherController, child) {
              return weatherController.isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Temperature Text
                        Text(
                          "${weatherController.weather?.temperature ?? 'N/A'}°F",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontSize: 60,
                                fontWeight: FontWeight.w600,
                              ),
                          textAlign: TextAlign.center,
                        ),

                        // Weather Description
                        Text(
                          weatherController.weather?.weatherDescription ??
                              'Loading...',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                          textAlign: TextAlign.center,
                        ),

                        // Weather Image
                        Image.asset(
                          _getWeatherImage(
                            weatherController.weather?.weatherDescription ??
                                "clear Sky",
                            weatherController.weather?.isDay ?? true,
                          ),
                          width: 320,
                          height: 320,
                          fit: BoxFit.cover,
                        ),

                        // Weather Box with 7-day forecast
                        Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          child: Container(
                            width: 340,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                // 7-Day Forecast List
                                Column(
                                  children: weatherController
                                          .weather?.weeklyForecast
                                          .map((forecast) => _buildForecastRow(
                                              forecast,
                                              weatherController
                                                      .weather?.isDay ??
                                                  true,
                                              context))
                                          .toList() ??
                                      [],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForecastRow(
      DailyForecast forecast, bool isDay, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: [
          // Day of the Week
          Expanded(
            flex: 3,
            child: Text(
              forecast.day,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),

          // Weather Icon

          // Weather Icon
          SizedBox(
            width: 45,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                _getWeatherIcon(forecast.weatherDescription, isDay, context),
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Temperature
          Expanded(
            flex: 3,
            child: Text(
              "${forecast.temperature.toStringAsFixed(1)}°F",
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  String _getWeatherIcon(String description, bool isDay, BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    switch (description.toLowerCase()) {
      case "clear sky":
        return isDay
            ? "assets/icons/clear-day.png"
            : (isDarkMode
                ? "assets/icons/clear-night-dark.png"
                : "assets/icons/clear-night-light.png");
      case "partly cloudy":
      case "cloudy":
        return isDay
            ? "assets/icons/day-cloudy.png"
            : (isDarkMode
                ? "assets/icons/night-cloudy-dark.png"
                : "assets/icons/night-cloudy-light.png");
      case "fog":
        return isDarkMode
            ? "assets/icons/fog-dark.png"
            : "assets/icons/fog-light.png";
      case "rain":
        return "assets/icons/rain.png";
      case "snow":
        return "assets/icons/snow.png";
      case "wind":
        return "assets/icons/windy.png";
      default:
        return isDay
            ? "assets/icons/clear-day.png"
            : (isDarkMode
                ? "assets/icons/clear-night-dark.png"
                : "assets/icons/clear-night-light.png");
    }
  }

  String _getWeatherImage(String description, bool isDay) {
    switch (description.toLowerCase()) {
      case "clear sky":
        return isDay
            ? "assets/images/day-clear.png"
            : "assets/images/night-clear.png";
      case "partly cloudy":
      case "cloudy":
        return isDay
            ? "assets/images/day-cloudy.png"
            : "assets/images/night-cloudy.png";
      case "rain":
        return isDay
            ? "assets/images/day-rain.png"
            : "assets/images/night-rain.png";
      case "snow":
        return isDay
            ? "assets/images/day-snow.png"
            : "assets/images/night-snow.png";
      case "wind":
        return isDay
            ? "assets/images/day-wind.png"
            : "assets/images/night-wind.png";
      default:
        return isDay
            ? "assets/images/day-clear.png"
            : "assets/images/night-clear.png";
    }
  }
}
