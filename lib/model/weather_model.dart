class WeatherData {
  final Main main;
  final List<Weather> weather;
  final double wind;
  final DateTime sunrise;
  final DateTime sunset;
  final int visibility;
  WeatherData({
    required this.main,
    required this.weather,
    required this.wind,
    required this.sunrise,
    required this.sunset,
    required this.visibility
  });

  factory WeatherData.fromMap(Map<String, dynamic> map) {
    return WeatherData(
      main: Main.fromMap(map['main']),
      weather: List<Weather>.from(map['weather'].map((item) => Weather.fromMap(item))),
      wind: map['wind']['speed'],
      sunrise: _formatUnixTime(map['sys']['sunrise'],map['timezone']),
      sunset: _formatUnixTime(map['sys']['sunset'],map['timezone']),
      visibility: map['visibility'],
    );
  }
  static DateTime _formatUnixTime(unixTime,timezone) {
    if (unixTime == null || timezone == null) {
        return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
    }
    return DateTime.fromMillisecondsSinceEpoch(unixTime * 1000, isUtc: true)
      .add(Duration(seconds: timezone));
  }
}

class Main {
  int temp;
  int feelsLike;
  int pressure;
  int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
  });

  factory Main.fromMap(Map<String, dynamic> map) => Main(
        temp: _convertToC(map['temp'].toDouble()),
        feelsLike: _convertToC(map['feels_like'].toDouble()),
        pressure: map['pressure'] ?? 0,
        humidity: map['humidity'] ?? 0,
      );
  static int _convertToC(double kelvin) {
    return (kelvin - 273.15).round();
  }
}


class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromMap(Map<String, dynamic> map) => Weather(
        id: map['id'],
        main: map['main'],
        description: map['description'],
        icon: map['icon'],
      );
}


