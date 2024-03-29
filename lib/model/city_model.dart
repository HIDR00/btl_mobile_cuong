import 'package:hive/hive.dart';

part 'city_model.g.dart';

@HiveType(typeId: 0)
class CityModel {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late double lat;
  @HiveField(2)
  late double lon;
  @HiveField(3)
  late String country;
  @HiveField(4)
  String? state;

  CityModel({required this.name, required this.lat, required this.lon, required this.country, this.state});

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      name: map['name'] ?? '',
      lat: map['lat'] ?? 0,
      lon: map['lon'] ?? 0,
      country: map['country'] ?? '',
      state: map['state'] ?? '',
    );
  }
}
