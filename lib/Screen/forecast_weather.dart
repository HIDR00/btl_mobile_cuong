import 'package:cuongkh1_project/model/forecast_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/setting_state.dart';
import '../services/constants.dart';

class Forecast extends StatefulWidget {
  const Forecast({super.key});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Selector<SettingState, List<ForecastModel>>(
        selector: (ctx, state) => state.listForerestWeather,
        builder: (context, value, child) {
          if (!value.isNotEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return GestureDetector(
            onTap: () {
              print(value.length);
            },
            child: SizedBox(
              width: double.infinity,
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.length,
                itemBuilder: (BuildContext context, int index) {
                  return index % 8 == 0
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 70,
                              height: 80,
                              decoration: BoxDecoration(
                                  gradient: Constants().ColorPrimary,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${DateFormat('EEE').format(value[index].dtTxt)}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Image.network(
                                      'https://openweathermap.org/img/wn/${value[index].weather[0].icon}@2x.png',
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      '${value[index].main.temp}',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                      : SizedBox();
                },
              ),
            ),
          );
        });
  }
}
