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
  num tempMin;
  num tempMax;
  num pressure;
  num seaLevel;
  num grndLevel;
  num humidity;
  num tempKf;

  Main({
    this.temp,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  Main.fromJson(Map<String, dynamic> json)
      : temp = json['temp'] as num,
        tempMin = json['tempMin'] as num,
        tempMax = json['tempMax'] as num,
        pressure = json['pressure'] as num,
        seaLevel = json['seaLevel'] as num,
        grndLevel = json['grndLevel'] as num,
        humidity = json['humidity'] as num,
        tempKf = json['tempKf'] as num;
}

class Sys {
  num type;
  num id;
  num message;
  String country;
  num sunrise;
  num sunset;
  String pod;

  Sys({
    this.type,
    this.id,
    this.message,
    this.country,
    this.sunrise,
    this.sunset,
    this.pod,
  });

  Sys.fromJson(Map<String, dynamic> json)
      : id = json['id'] as num,
        type = json['type'] as num,
        message = json['description'] as num,
        country = json['country'],
        sunrise = json['sunrise'] as num,
        sunset = json['sunset'] as num,
        pod = json['pod'];
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
    if (jsons != null)
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
