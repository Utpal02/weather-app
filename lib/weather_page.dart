import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('e51152eb87dac91520e918599fceaf7d');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();
    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //any errors
    catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/load.json"; // default to sunny

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return "assets/cloud.json";
      case 'mist':
        return "assets/mist.json";
      case 'smoke':
        return "assets/smoke.json";
      case 'haze':
        return "assets/haze.json";
      case 'dust':
        return "assets/haze.json";
      case 'fog':
        return "assets/smoke.json";
      case 'rain':
        return "assets/rain.json";
      case 'drizzler':
        return "assets/rain.json";
      case 'shower rain':
        return "assets/rain.json";
      case 'thunderstorm':
        return "assets/thunder.json";
      case 'clear':
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  //init state
  @override
  void initState() {
    super.initState();
    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(
              _weather?.cityName ?? "Loading City ... ",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            //temperature
            Text(
              '${_weather?.temperature.round() ?? "... "}°C',
              style: const TextStyle(
                color: Color.fromARGB(255, 25, 19, 19),
                fontWeight: FontWeight.bold,
                fontSize: 45,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //weather condition
            Text(
              _weather?.mainCondition ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
