import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

import '../model/forecast_model.dart';
import '../services/constants.dart';

class ChartWeather extends StatefulWidget {
  const ChartWeather({super.key, required this.listWeather});
  final List<ForecastModel> listWeather;
  @override
  State<ChartWeather> createState() => _ChartWeatherState();
}

class _ChartWeatherState extends State<ChartWeather> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: Constants().ColorPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            height: 130,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.listWeather.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 55,
                      height: 40,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${widget.listWeather[index].dtTxt.hour} h',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Image.network(
                              'https://openweathermap.org/img/wn/${widget.listWeather[index].weather[0].icon}@2x.png',
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${widget.listWeather[index].main.temp}',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                const Text(
                                  'o',
                                  style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: LineChart(
                swapAnimationDuration: const Duration(milliseconds: 150),
                swapAnimationCurve: Curves.linear,
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      )),
                  borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        bottom: BorderSide(color: Colors.transparent),
                        left: BorderSide(color: Colors.transparent),
                        right: BorderSide(color: Colors.transparent),
                        top: BorderSide(color: Colors.transparent),
                      )),
                  lineBarsData: [
                    LineChartBarData(
                        isCurved: true,
                        color: Colors.white,
                        barWidth: 4,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) =>
                              FlDotCirclePainter(
                            radius: 5,
                            color: Colors.amber,
                          ),
                        ),
                        spots: [
                          FlSpot(0, widget.listWeather[0].main.temp.toDouble()),
                          FlSpot(1, widget.listWeather[1].main.temp.toDouble()),
                          FlSpot(2, widget.listWeather[2].main.temp.toDouble()),
                          FlSpot(3, widget.listWeather[3].main.temp.toDouble()),
                          FlSpot(4, widget.listWeather[4].main.temp.toDouble()),
                        ]),
                  ],
                  minX: 0,
                  maxX: 4,
                  minY: widget.listWeather
                      .map((weather) => weather.main.temp)
                      .reduce(min)
                      .toDouble(),
                  maxY: widget.listWeather
                      .map((weather) => weather.main.temp)
                      .reduce(max)
                      .toDouble(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
