import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hava_durumu/screens/home_page.dart';
import 'package:flutter_hava_durumu/screens/result_page.dart';
import 'package:flutter_hava_durumu/untils/location_helper.dart';
import 'package:flutter_hava_durumu/untils/weather_data.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  LocationHelper? locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData!.getCurrentLocation();

    if (locationData!.latitude == null || locationData!.longitude == null) {
      debugPrint("Konum bilgileri gelmiyor.");
    } else {
      debugPrint("latitude: " + locationData!.latitude.toString());
      debugPrint("longitude: " + locationData!.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      debugPrint("API den sıcaklık veya durum bilgisi boş dönüyor.");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ResultPage()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    weatherData: weatherData,
                  )));
    }
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
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          margin:
              const EdgeInsets.only(top: 150, bottom: 150, left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Konumunuzu otamatik\nolarak tesbit ekmek için\nuygulamanın konum iznine ihtiyacı var',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 40)),
                  onPressed: () {
                    getWeatherData();
                  },
                  child: const Text(
                    'İzin ver',
                    style: TextStyle(color: Colors.black),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 40)),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResultPage()));
                  },
                  child: const Text(
                    'İzin verme',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
