import 'package:flutterweather/models/coord.dart';
import 'package:flutterweather/models/weather_models.dart';

class CurrentWeather {
  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  Wind wind;
  Clouds clouds;
  num dt;
  Sys sys;
  num timezone;
  num id;
  String name;
  num cod;

  CurrentWeather({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  CurrentWeather.fromJson(Map<String, dynamic> json)
      : coord = Coord.fromJson(json['coord']),
        weather = Weather.fromListJson(json['weather']),
        base = json['base'] as String,
        main = Main.fromJson(json['main']),
        wind = Wind.fromJson(json['wind']),
        clouds = Clouds.fromJson(json['clounds']),
        dt = json['dt'] as num,
        sys = Sys.fromJson(json['sys']),
        timezone = json['timezone'] as num,
        id = json['id'] as num,
        name = json['name'] as String,
        cod = json['cod'] as num;
}