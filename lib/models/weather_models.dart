class Clouds {
  num all;

  Clouds({
    this.all,
  });

  Clouds.fromJson(Map<String, dynamic> json)
      : all = json != null ? json['all'] as num : 0;
}

class Main {
  num temp;
  num pressure;
  num humidity;
  num tempMin;
  num tempMax;

  Main({
    this.temp,
    this.pressure,
    this.humidity,
    this.tempMin,
    this.tempMax,
  });

  Main.fromJson(Map<String, dynamic> json)
      : temp = json['temp'] as num,
        pressure = json['pressure'] as num,
        humidity = json['humidity'] as num,
        tempMin = json['tempMin'] as num,
        tempMax = json['tempMax'] as num;
}

class Sys {
  num type;
  num id;
  num message;
  String country;
  num sunrise;
  num sunset;

  Sys({
    this.type,
    this.id,
    this.message,
    this.country,
    this.sunrise,
    this.sunset,
  });

  Sys.fromJson(Map<String, dynamic> json)
      : id = json['id'] as num,
        type = json['type'] as num,
        message = json['description'] as num,
        country = json['country'],
        sunrise = json['sunrise'] as num,
        sunset = json['sunset'] as num;
}

class Weather {
  num id;
  String main;
  String description;
  String icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  Weather.fromJson(Map<String, dynamic> json)
      : id = json['id'] as num,
        main = json['main'],
        description = json['description'],
        icon = json['icon'];

  static List<Weather> fromListJson(List<dynamic> jsons) {
    List<Weather> weathers = [];

    for (var i = 0; i < jsons.length; i++)
      weathers.add(Weather.fromJson(jsons[i]));

    return weathers;
  }
}

class Wind {
  num speed;
  num deg;

  Wind({
    this.speed,
    this.deg,
  });
  Wind.fromJson(Map<String, dynamic> json)
      : speed = json['speed'] as num,
        deg = json['deg'] as num;
}
