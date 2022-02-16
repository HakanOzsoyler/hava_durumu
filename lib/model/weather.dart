import 'package:flutter/material.dart';

class Weather {
  final String cityName;
  final String description;
  final int temp;
  final int feelsLike;
  final int tempMin;
  final int tempMax;
  final int pressure;
  final int humidity;
  final int? currentCondition;
  final AssetImage image;

  const Weather({
    this.currentCondition,
    required this.cityName,
    required this.description,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.image,
  });
}
