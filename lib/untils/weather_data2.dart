import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hava_durumu/model/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  static const apiKey = '539367242752c54724ec1d353b1052b0';

  static Future<List<String>> searchCities({@required String? query}) async {
    const limit = 3;
    final url =
        'https://api.openweathermap.org/geo/1.0/direct?q=$query&limit=$limit&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);

    return body.map<String>((json) {
      final city = json['name'];
      final country = json['country'];

      return '$city, $country';
    }).toList();
  }

  static Future<Weather> getWeather({@required String? city}) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&lang=tr&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);

    return _convert(body);
  }

  static Weather _convert(json) {
    final int currentCondition = json['weather'][0]['id'];
    final description = json['weather'][0]['description'];
    final cityName = json['name'];
    final int temp = (json['main']['temp']).toInt();
    final int feelsLike = (json['main']['feels_like']).toInt();
    final int tempMin = (json['main']['temp_min']).toInt();
    final int tempMax = (json['main']['temp_max']).toInt();
    final int pressure = json['main']['pressure'];
    final int humidity = json['main']['humidity'];

    if (currentCondition > 800) {
      return Weather(
          cityName: cityName,
          description: description,
          temp: temp,
          feelsLike: feelsLike,
          tempMin: tempMin,
          tempMax: tempMax,
          pressure: pressure,
          humidity: humidity,
          image: const AssetImage("assets/cloudy (1).png"));
    } else if ((currentCondition < 800 && currentCondition >= 700)) {
      return Weather(
          cityName: cityName,
          description: description,
          temp: temp,
          feelsLike: feelsLike,
          tempMin: tempMin,
          tempMax: tempMax,
          pressure: pressure,
          humidity: humidity,
          image: const AssetImage("assets/fog (1).png"));
    } else if ((currentCondition <= 700 && currentCondition >= 600)) {
      return Weather(
          cityName: cityName,
          description: description,
          temp: temp,
          feelsLike: feelsLike,
          tempMin: tempMin,
          tempMax: tempMax,
          pressure: pressure,
          humidity: humidity,
          image: const AssetImage("assets/snow (1).png"));
    } else if ((currentCondition <= 600 && currentCondition >= 500)) {
      return Weather(
          cityName: cityName,
          description: description,
          temp: temp,
          feelsLike: feelsLike,
          tempMin: tempMin,
          tempMax: tempMax,
          pressure: pressure,
          humidity: humidity,
          image: const AssetImage("assets/raining (1).png"));
    } else if (currentCondition < 500) {
      return Weather(
          cityName: cityName,
          description: description,
          temp: temp,
          feelsLike: feelsLike,
          tempMin: tempMin,
          tempMax: tempMax,
          pressure: pressure,
          humidity: humidity,
          image: const AssetImage("assets/storm (1).png"));
    } else {
      return Weather(
          cityName: cityName,
          description: description,
          temp: temp,
          feelsLike: feelsLike,
          tempMin: tempMin,
          tempMax: tempMax,
          pressure: pressure,
          humidity: humidity,
          image: const AssetImage("assets/sun (1).png"));
    }
  }
}
