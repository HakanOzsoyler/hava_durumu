import 'package:flutter/material.dart';
import 'package:flutter_hava_durumu/screens/result_page.dart';
import 'package:flutter_hava_durumu/untils/weather_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final WeatherData? weatherData;

  const HomePage({
    Key? key,
    this.weatherData,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? temperature;
  AssetImage? weatherIcon;
  String? cityName;
  int? feelsLike;
  int? tempMax;
  int? tempMin;
  int? currentPressure;
  int? currentHumidity;
  String? currentDescription;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature!.round();
      cityName = weatherData.cityName;
      feelsLike = weatherData.feelsLike!.round();
      tempMax = weatherData.tempMax!.round();
      tempMin = weatherData.tempMin!.round();
      currentPressure = weatherData.currentPressure;
      currentHumidity = weatherData.currentHumidity;
      currentDescription = weatherData.currentDescription;

      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      weatherIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: [Colors.blueAccent, Colors.lightBlueAccent])),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              havaDurumuList(),
              Expanded(
                flex: 3,
                child: havaDurumu(),
              ),
              Expanded(
                flex: 2,
                child: havaDurumuDetay(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton havaDurumuList() {
    return IconButton(
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ResultPage()));
      },
      icon: const Icon(
        Icons.more_vert,
        size: 30,
      ),
    );
  }

  Row havaDurumu() {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${temperature!}°C",
                style: const TextStyle(
                    fontSize: 70,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "$currentDescription",
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "$cityName",
                style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Hissedilen Sıcaklık: $feelsLike",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration:
                BoxDecoration(image: DecorationImage(image: weatherIcon!)),
          ),
        ),
      ],
    );
  }

  Column havaDurumuDetay() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Hava Durumu",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        const Divider(
          endIndent: 20,
          indent: 20,
          thickness: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(40)),
                    height: 50,
                    width: 50,
                    child: const Icon(FontAwesomeIcons.thermometerThreeQuarters,
                        color: Colors.blue, size: 30),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Max sıcaklık",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "$tempMax",
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(40)),
                    height: 50,
                    width: 50,
                    child: const Icon(FontAwesomeIcons.thermometerEmpty,
                        color: Colors.blue, size: 30),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Min Sıcaklık",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "$tempMin",
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(40)),
                    height: 50,
                    width: 50,
                    child: const Icon(Icons.air, color: Colors.blue, size: 30),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Basınç",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "$currentPressure",
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(40)),
                    height: 50,
                    width: 50,
                    child: const Icon(
                      Icons.opacity,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nem",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "%$currentHumidity ",
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
