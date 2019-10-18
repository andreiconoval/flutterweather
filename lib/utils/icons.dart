import 'package:flutter/material.dart';
import 'package:flutterweather/presentation/weather_icons_icons.dart';

Icon getWheatherIcon(num id, Color color, double size) {

  /// FRom https://openweathermap.org/weather-conditions
  switch (id) {
    case 800:
      {
        return Icon(
          WeatherIcons.wi_day_sunny,
          size: size,
          color: color,
        );
      }
      break;

    case 803:
      {
        return Icon(
          WeatherIcons.wi_cloudy,
          size: size,
          color: color,
        );
      }
      break;
      case 802:
      {
        return Icon(
          WeatherIcons.wi_cloud,
          size: size,
          color: color,
        );
      }
      break;
      case 801:
      {
        return Icon(
          WeatherIcons.wi_cloud,
          size: size,
          color: color,
        );
      }
      break;

    default:
      {
        return Icon(
          WeatherIcons.wi_na,
          size: size,
          color: color,
        );
      }
  }
}
