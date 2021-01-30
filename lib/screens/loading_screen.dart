import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_weather_app/utils/location_helper.dart';
import 'package:flutter_weather_app/utils/weather.dart';
import 'package:get/get.dart';
import 'package:flutter_weather_app/screens/weather_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationHelper _locationHelper;

  Future<void> getLocationData() async {
    _locationHelper = LocationHelper();
    await _locationHelper.getCurrentLocation();
    if (_locationHelper.longitude == null || _locationHelper.latitude == null) {
      print("data not fetched!");
    } else {
      print(_locationHelper.latitude);
    }
  }

  void getWeatherData() async {
    // Fetch the location
    await getLocationData();
    // Fetch the current weather
    WeatherData weatherData = WeatherData(locationData: _locationHelper);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      // todo: Handle no weather
    }
    Get.to(MainScreen(weatherData: weatherData,));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.blue],
          ),
        ),
        child: Center(
          child: SpinKitRipple(
            color: Colors.white,
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
