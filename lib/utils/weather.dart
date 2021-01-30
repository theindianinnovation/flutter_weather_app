import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_weather_app/utils/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

const apiKey = '******************';


class WeatherData {
  WeatherData({@required this.locationData});

  LocationHelper locationData;
  int currentTemperature;
  int currentCondition;
  String currentLocation;

  Future<void> getCurrentTemperature() async {
    Response response = await get(
        'http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric');

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);
       print(currentWeather);
      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        currentLocation=currentWeather['name'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature!');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      var bgimage='';
      return WeatherDisplayData(
        weatherIcon: Icon(FontAwesomeIcons.cloud,size: 50,color: Colors.white,),
        weatherImage: AssetImage('assets/cloud.png'),
      );
    } else {
      var now = new DateTime.now();

      if (now.hour >= 15) {
        return WeatherDisplayData(
          weatherImage: AssetImage('assets/night.png'),
          weatherIcon: Icon(FontAwesomeIcons.cloudMoon,size: 50,color: Colors.white,),
        );
      } else {
        return WeatherDisplayData(
          weatherIcon: Icon(FontAwesomeIcons.cloudSun,size: 50,color: Colors.white,),
          weatherImage: AssetImage('assets/sunny.png'),
        );
      }
    }
  }
}

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({@required this.weatherIcon, @required this.weatherImage});
}
