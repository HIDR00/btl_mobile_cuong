import 'dart:convert';
import 'package:cuongkh1_project/model/city_model.dart';
import 'package:cuongkh1_project/model/forecast_model.dart';
import 'package:cuongkh1_project/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import '../services/api_services.dart';

class SettingState extends ChangeNotifier {
  CityModel? initCity;
  List<CityModel> listCity = [];
  WeatherData? weatherData;
  List<ForecastModel> listForerestWeather = [];

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }


  Future fetchCityData() async {
    Position position = await _determinePosition();
    String lat = position.latitude.toString();
    String lon = position.longitude.toString();
    print("${lat} - ${lon}");
    final Response response = await ApiServices().get(
        'http://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=1&appid=fadf9668e3f907defd8764e9a3debdb8');
    final body = jsonDecode(response.body);
    initCity = CityModel.fromMap(body.first);
    print(initCity?.name);
    print(initCity?.country);
    notifyListeners();
  }

  Future fetchListCityData(String name) async {
    listCity = [];
    final Response response = await ApiServices().get(
        'http://api.openweathermap.org/geo/1.0/direct?q=$name&limit=10&appid=fadf9668e3f907defd8764e9a3debdb8');
    final body = jsonDecode(response.body);
    for (var i in body) {
      CityModel city = CityModel.fromMap(i);
      listCity.add(city);
    }
    print(listCity.first.name);
    notifyListeners();
  }

  Future fetchLatLonCityData(String lat, String lon) async {
    final Response response = await ApiServices().get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=fadf9668e3f907defd8764e9a3debdb8');
    final body = jsonDecode(response.body);
    weatherData = WeatherData.fromMap(body);
    print(weatherData?.main.feelsLike);
    notifyListeners();
  }

  Future fetchForecastWeatherData(String lat, String lon) async {
    List<ForecastModel> tmp = [];
    final Response response = await ApiServices().get(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=fadf9668e3f907defd8764e9a3debdb8');
    final body = jsonDecode(response.body);
    for (var i in body['list']) {
      ForecastModel weather = ForecastModel.fromMap(i);
      tmp.add(weather);
    }
    listForerestWeather = tmp;
    print(listForerestWeather.length);
    notifyListeners();
  }
}
