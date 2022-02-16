import 'package:flutter/material.dart';
import 'package:flutter_hava_durumu/model/weather.dart';
import 'package:flutter_hava_durumu/screens/result_page.dart';
import 'package:flutter_hava_durumu/untils/weather_data2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePagee extends StatefulWidget {
  final String suggestion;
  const HomePagee({Key? key, required this.suggestion}) : super(key: key);

  @override
  _HomePageeState createState() => _HomePageeState();
}

class _HomePageeState extends State<HomePagee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Weather>(
        future: WeatherApi.getWeather(city: widget.suggestion),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildNoSuccess();
              } else {
                return buildResultSuccess(snapshot.data!);
              }
          }
        },
      ),
    );
  }

  Widget buildNoSuccess() {
    return Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          'İnternet bağlantınızı kontrol edin\n ve tekrar deneyin',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildResultSuccess(Weather weather) => Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightBlueAccent, Colors.blueAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          havaDurumuList(),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildDegrees(weather),
                      Text(
                        weather.description,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        weather.cityName,
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Hissedilen Sıcaklık: ${weather.feelsLike}",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Image(
                      image: weather.image,
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Hava Durumu",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
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
                            child: const Icon(
                                FontAwesomeIcons.thermometerThreeQuarters,
                                color: Colors.blue,
                                size: 30),
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
                              weather.tempMax.toString(),
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
                              weather.tempMin.toString(),
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
                            child: const Icon(Icons.air,
                                color: Colors.blue, size: 30),
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
                              weather.pressure.toString(),
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
                              "%${weather.humidity} ",
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
            ),
          ),
        ]),
      ));
  Widget buildDegrees(Weather weather) {
    const style = TextStyle(
      fontSize: 75,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Opacity(
          opacity: 0,
          child: Text('°', style: style),
        ),
        Text('${weather.temp}°', style: style),
      ],
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
}
