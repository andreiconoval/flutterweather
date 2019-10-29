import 'package:flutterweather/models/coord.dart';

class City {
  final int id;
  final String name;
  final String country;
  final Coord coord;

  City({this.id, this.name, this.country, this.coord});

  City.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        country = json['country'],
        coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;

  List<City> fromListJson(List<dynamic> jsons) {
    List<City> cities = [];

    try {
      for (var i = 0; i < jsons.length; i++)
        cities.add(City.fromJson(jsons[i]));
    } catch (e) {
      return null;
    }

    return cities;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country': country,
        'coord': coord != null ? coord.toJson() : null,
      };
}
