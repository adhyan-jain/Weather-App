import 'package:flutter/material.dart';
import '../screens/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  final List<String> cities = ['Delhi', 'Mumbai', 'Bengaluru', 'Chennai'];
  String? dropdownValue;

  void _navigateToWeather(String cityName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherScreen(cityName: cityName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherNow'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_cityController.text.trim().isNotEmpty) {
                      _navigateToWeather(_cityController.text.trim());
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Or select a city'),
              items: cities.map((city) {
                return DropdownMenuItem(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (value) {
                dropdownValue = value;
                if (value != null) _navigateToWeather(value);
              },
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 10,
              children: cities.map((city) {
                return ElevatedButton(
                  onPressed: () => _navigateToWeather(city),
                  child: Text(city),
                );
              }).toList(),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                _navigateToWeather('current');
              },
              icon: const Icon(Icons.my_location),
              label: const Text('Use Current Location'),
            ),
          ],
        ),
      ),
    );
  }
}
