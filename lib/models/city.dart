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
        coord = Coord.fromJson(json['coord']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country': country,
        'coord': coord.toJson(),
      };
}