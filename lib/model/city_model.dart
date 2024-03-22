
class CityModel {
    late String name;
    late double lat;
    late double lon;
    late String country;
    String? state;
  
  CityModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    this.state
  });


  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      name: map['name'] ?? '',
      lat: map['lat'] ?? 0,
      lon: map['lon'] ?? 0,
      country: map['country'] ?? '',
      state: map['state'] ?? '',
    );
  }

  // Map<String, dynamic> toJson() => {
  //   "name": name,
  //   "lat": lat,
  //   "lon": lon,
  //   "country": country,
  //   "state": state
  // };

  // factory CityModel.fromJson(String source) => CityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
