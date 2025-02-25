import 'package:flutter/material.dart';
import '../controller/weatherController.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  _WeatherViewState createState() => _WeatherViewState();
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
      // child: Center(
      //   child: _controller.isLoading
      //       ? CupertinoActivityIndicator()
      //       : Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(
      //               "Current Temp: ${_controller.weather?.temperature}°F",
      //               style: CupertinoTheme.of(context).textTheme.textStyle,
      //             ),
      //             Text(
      //               "Weather Code: ${_controller.weather?.weatherCode}",
      //               style: CupertinoTheme.of(context).textTheme.textStyle,
      //             ),
      //             Text(
      //               _controller.weather?.isDay == true ? "Daytime" : "Nighttime",
      //               style: CupertinoTheme.of(context).textTheme.textStyle,
      //             ),
      //             Text(
      //               "Daily Weather Codes: ${_controller.weather?.dailyWeatherCodes.join(", ")}",
      //               style: CupertinoTheme.of(context).textTheme.textStyle,
      //             ),
      //             CupertinoButton(
      //               child: Text("Refresh"),
      //               onPressed: _loadWeather,
      //             ),
      //           ],
      //         ),
      // ),
    );
  }
}
