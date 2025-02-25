import 'package:flutter/material.dart';
import '../controller/weatherController.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final WeatherController _controller = WeatherController();

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    await _controller.loadWeather();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
      ),
      body: Center(
        child: _controller.isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Current Temp: ${_controller.weather?.temperature}°F",
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Weather Code: ${_controller.categorizeWeatherCode(_controller.weather?.weatherCode ?? 0)}",
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _controller.weather?.isDay == true
                        ? "Daytime"
                        : "Nighttime",
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Daily Weather Codes: ${_controller.weather?.dailyWeatherCodes.join(", ")}",
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _loadWeather,
                    child: const Text("Refresh"),
                  ),
                ],
              ),
      ),
    );
  }
}
