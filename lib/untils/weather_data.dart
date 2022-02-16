import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hava_durumu/untils/location_helper.dart';
import 'package:http/http.dart' as http;

const apikey = "539367242752c54724ec1d353b1052b0";

class WeatherDisplayData {
  AssetImage? weatherIcon;

  WeatherDisplayData({@required this.weatherIcon});
}

class WeatherData {
  WeatherData({@required this.locationData});

  LocationHelper? locationData;
  int? currentCondition;
  String? cityName;
  double? currentTemperature;
  double? feelsLike;
  double? tempMax;
  double? tempMin;
  int? currentPressure;
  int? currentHumidity;
  String? currentDescription;

  Future<void> getCurrentTemperature() async {
    final response = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?lat=${locationData!.latitude}&lon=${locationData!.longitude}&appid=$apikey&lang=tr&units=metric"));

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        cityName = currentWeather["name"];
        currentTemperature = currentWeather["main"]["temp"];
        feelsLike = currentWeather["main"]["feels_like"];
        tempMax = currentWeather["main"]["temp_max"];
        tempMin = currentWeather["main"]["temp_min"];
        currentPressure = currentWeather["main"]["pressure"];
        currentHumidity = currentWeather["main"]["humidity"];
        currentCondition = currentWeather["weather"][0]["id"];
        currentDescription = currentWeather["weather"][0]["description"];

        debugPrint("şehir ismi: $cityName");
        debugPrint("gelen int: $currentCondition");
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint("Apiden veri gelmiyor");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition! > 800) {
      return WeatherDisplayData(
          weatherIcon: const AssetImage("assets/cloudy (1).png"));
    } else if ((currentCondition! < 800 && currentCondition! >= 700)) {
      return WeatherDisplayData(
          weatherIcon: const AssetImage("assets/fog (1).png"));
    } else if ((currentCondition! <= 700 && currentCondition! >= 600)) {
      return WeatherDisplayData(
          weatherIcon: const AssetImage("assets/snow (1).png"));
    } else if ((currentCondition! <= 600 && currentCondition! >= 500)) {
      return WeatherDisplayData(
          weatherIcon: const AssetImage("assets/raining (1).png"));
    } else if (currentCondition! < 500) {
      return WeatherDisplayData(
          weatherIcon: const AssetImage("assets/storm (1).png"));
    } else {
      return WeatherDisplayData(
          weatherIcon: const AssetImage("assets/sun (1).png"));
    }
  }
}
