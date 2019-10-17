

import 'package:flutterweather/models/city.dart';
import 'package:flutterweather/models/weather_models.dart';

class The5Dayforecast {
    String cod;
    double message;
    int cnt;
    List<ListElement> list;
    City city;

    The5Dayforecast({
        this.cod,
        this.message,
        this.cnt,
        this.list,
        this.city,
    });
}



class ListElement {
    int dt;
    MainClass main;
    List<Weather> weather;
    Clouds clouds;
    Wind wind;
    Sys sys;
    String dtTxt;

    ListElement({
        this.dt,
        this.main,
        this.weather,
        this.clouds,
        this.wind,
        this.sys,
        this.dtTxt,
    });
}

class Clouds {
    int all;

    Clouds({
        this.all,
    });
}

class MainClass {
    double temp;
    double tempMin;
    double tempMax;
    double pressure;
    double seaLevel;
    double grndLevel;
    int humidity;
    double tempKf;

    MainClass({
        this.temp,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.seaLevel,
        this.grndLevel,
        this.humidity,
        this.tempKf,
    });
}

class Sys {
    Pod pod;

    Sys({
        this.pod,
    });
}

enum Pod { D, N }

class Weather {
    int id;
    MainEnum main;
    Description description;
    Icon icon;

    Weather({
        this.id,
        this.main,
        this.description,
        this.icon,
    });
}

enum Description { CLEAR_SKY, SCATTERED_CLOUDS, FEW_CLOUDS }

enum Icon { THE_01_D, THE_01_N, THE_03_D, THE_02_D }

enum MainEnum { CLEAR, CLOUDS }

