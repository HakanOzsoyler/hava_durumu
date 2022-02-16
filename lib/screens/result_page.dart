import 'package:flutter/material.dart';
import 'package:flutter_hava_durumu/model/city.dart';
import 'package:flutter_hava_durumu/model/database_helper.dart';
import 'package:flutter_hava_durumu/screens/home_page.dart';
import 'package:flutter_hava_durumu/screens/home_pagee.dart';
import 'package:flutter_hava_durumu/screens/search_page.dart';
import 'package:flutter_hava_durumu/untils/location_helper.dart';
import 'package:flutter_hava_durumu/untils/weather_data.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  LocationHelper? locationData;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData!.getCurrentLocation();
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();
    if (weatherData.currentTemperature != null ||
        weatherData.currentCondition != null) {
      //Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    weatherData: weatherData,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Şehirleri yönet'),
      ),
      body: FutureBuilder<List<City>>(
        future: DatabaseHelper.instance.getCitys(),
        builder: (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              InkWell(
                  onTap: () {
                    getLocationData();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: const [
                        Icon(Icons.location_on),
                        Text('Lokasyon'),
                      ],
                    ),
                  )),
              snapshot.data!.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Text(
                          'Liste Boş',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView(
                        children: snapshot.data!.map((city) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePagee(
                                            suggestion: city.cityName!)));
                              },
                              title: Text(city.cityName!),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    DatabaseHelper.instance.remove(city.id!);
                                  });
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
              eklemeEkrani()
            ],
          );
        },
      ),
    );
  }

  eklemeEkrani() {
    return Column(
      children: [
        const Divider(
          indent: 10,
          endIndent: 10,
          thickness: 1,
          color: Colors.white54,
        ),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
            child: const Text(
              'Şehir ekle',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ))
      ],
    );
  }
}
