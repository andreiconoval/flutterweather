import 'package:flutterweather/models/city.dart';
import 'package:flutterweather/models/weather_models.dart';

class The5Dayforecast {
  String cod;
  num message;
  num cnt;
  List<ForecastItem> list;
  City city;

  The5Dayforecast({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  The5Dayforecast.fromJson(Map<String, dynamic> json)
      : cod = json['cod'],
        message = json['message'],
        cnt = json['cnt'],
        list = ForecastItem.fromListJson(json['list']),
        city = City.fromJson(json['city']);
}

class ForecastItem {
  num dt;
  Main main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  Sys sys;
  DateTime dtTxt;

  ForecastItem({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.sys,
    this.dtTxt,
  });

  ForecastItem.fromJson(Map<String, dynamic> json)
      : dt = json['dt'] as num,
        main = Main.fromJson(json['main']),
        weather = Weather.fromListJson(json['weather']),
        clouds = Clouds.fromJson(json['clouds']),
        wind = Wind.fromJson(json['wind']),
        sys = Sys.fromJson(json['sys']),
        dtTxt =DateTime.parse(json['dt_txt']);

  static List<ForecastItem> fromListJson(List<dynamic> jsons) {
    List<ForecastItem> list = [];
    if (jsons != null)
      for (var i = 0; i < jsons.length; i++)
        list.add(ForecastItem.fromJson(jsons[i]));

    return list;
  }
}
