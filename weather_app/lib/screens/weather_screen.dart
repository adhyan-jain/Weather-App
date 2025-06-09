import 'package:flutter/material.dart';
import '../services/weather_services.dart';

class WeatherScreen extends StatefulWidget {
  final String cityName;
  const WeatherScreen({super.key, required this.cityName});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic>? weatherData;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      if (widget.cityName == 'current') {
        weatherData = await WeatherService().getWeatherByLocation();
      } else {
        weatherData = await WeatherService().getWeatherByCity(widget.cityName);

      }
    } catch (e) {
      error = e.toString();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather in ${widget.cityName}')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text('Error: $error'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        '${weatherData!['name']}',
                        style: const TextStyle(fontSize: 28),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${weatherData!['main']['temp']}°C',
                        style: const TextStyle(fontSize: 50),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${weatherData!['weather'][0]['main']}',
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        title: const Text('Humidity'),
                        trailing: Text('${weatherData!['main']['humidity']}%'),
                      ),
                      ListTile(
                        title: const Text('Wind Speed'),
                        trailing: Text('${weatherData!['wind']['speed']} m/s'),
                      ),
                    ],
                  ),
                ),
    );
  }
}
