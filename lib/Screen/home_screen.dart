import 'package:cuongkh1_project/Screen/chart_weater.dart';
import 'package:cuongkh1_project/Screen/forecast_weather.dart';
import 'package:cuongkh1_project/Screen/search_screen.dart';
import 'package:cuongkh1_project/controller/setting_state.dart';
import 'package:cuongkh1_project/model/city_model.dart';
import 'package:cuongkh1_project/model/forecast_model.dart';
import 'package:cuongkh1_project/model/weather_model.dart';
import 'package:cuongkh1_project/services/constants.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.city});
  final CityModel city;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SettingState>().fetchLatLonCityData(
        widget.city.lat.toString(), widget.city.lon.toString());
    context.read<SettingState>().fetchForecastWeatherData(
        widget.city.lat.toString(), widget.city.lon.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white.withOpacity(0.3),
                border: Border.all(color: Colors.grey)),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
              child: const TextField(
                enabled: false,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 20, right: 10, top: 10),
                ),
              ),
            ),
          )),
      body: Selector<SettingState, WeatherData?>(
          selector: (ctx, state) => state.weatherData,
          builder: (context, value, child) {
            if (value == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: Constants().ColorPrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.city.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.location_on,
                                color: Colors.white,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        value.main.temp.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        'o',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    value.weather[0].description,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    '${DateFormat('EEE').format(DateTime.now())}, ${DateFormat('MMM').format(DateTime.now())} ${DateFormat('D').format(DateTime.now())}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ],
                              ),
                              Image.network(
                                'https://openweathermap.org/img/wn/${value.weather[0].icon}@2x.png',
                                height: 150,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Selector<SettingState, List<ForecastModel>>(
                        selector: (ctx, state) => state.listForerestWeather,
                        builder: (context, value, child) {
                          if (value.isEmpty) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return ChartWeather(
                              listWeather: value.length >= 5 ? value.getRange(0, 5).toList() : value);
                        }),
                        SizedBox(height: 30),
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 17,
                                mainAxisSpacing: 8,
                                childAspectRatio: 4 / 2),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: Constants().ColorPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        child: Image.asset(
                                          "assets/humidity.png",
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Text('Humidity',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13))
                                    ],
                                  ),
                                  Center(
                                    child: Text('${value.main.humidity} %',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: Constants().ColorPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        child: Image.asset(
                                          "assets/windspeed.png",
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Text('Wind',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13))
                                    ],
                                  ),
                                  Center(
                                    child: Text('${value.wind} m/s',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: Constants().ColorPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Row(
                                    children: [
                                      SizedBox(
                                          height: 20,
                                          child: Icon(
                                            Icons.compare_arrows_outlined,
                                            color: Colors.white,
                                          )),
                                      SizedBox(width: 5),
                                      Text('Pressure',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13))
                                    ],
                                  ),
                                  Center(
                                    child: Text('${value.main.pressure} mb',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: Constants().ColorPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Row(
                                    children: [
                                      SizedBox(
                                          height: 20,
                                          child: Icon(
                                            Icons.remove_red_eye_outlined,
                                            color: Colors.white,
                                          )),
                                      SizedBox(width: 5),
                                      Text('Visibility',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13))
                                    ],
                                  ),
                                  Center(
                                    child: Text('${value.visibility / 1000} km',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: Constants().ColorPrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: DashedCircularProgressBar.aspectRatio(
                              aspectRatio: 2,
                              progress: (100.0 *
                                      ((DateTime.now().hour * 60 +
                                              DateTime.now().minute) -
                                          (value.sunrise.hour * 60 +
                                              value.sunrise.minute)) /
                                      ((value.sunset.hour * 60 +
                                              value.sunset.minute) -
                                          (value.sunrise.hour * 60 +
                                              value.sunrise.minute)))
                                  .clamp(0, 100),
                              startAngle: 270,
                              sweepAngle: 181,
                              circleCenterAlignment: Alignment.bottomCenter,
                              foregroundColor: Colors.yellow,
                              backgroundColor: Color(0xffeeeeee),
                              foregroundStrokeWidth: 3,
                              backgroundStrokeWidth: 2,
                              backgroundDashSize: 1,
                              seekColor: Colors.yellow,
                              seekSize: 22,
                              animation: true,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, left: 60),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    const Text('Sunrise',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${value.sunrise.hour.toString().padLeft(2, '0')}:${value.sunrise.minute.toString().padLeft(2, '0')}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                const SizedBox(width: 140),
                                Column(
                                  children: [
                                    const Text('Sunset',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${value.sunset.hour.toString().padLeft(2, '0')}:${value.sunset.minute.toString().padLeft(2, '0')}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Forecast(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
