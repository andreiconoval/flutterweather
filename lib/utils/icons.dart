import 'package:flutter/material.dart';
import 'package:flutterweather/presentation/weather_icons_icons.dart';

Icon getWheatherIcon(num id, Color color, double size, DateTime dt) {
  bool isDay = dt.hour > 6 && dt.hour < 20;

  /// FRom https://openweathermap.org/weather-conditions
  switch (id) {
    case 800:
      {
        return Icon(
          isDay ? WeatherIcons.wi_day_sunny : WeatherIcons.wi_night_clear,
          size: size,
          color: color,
        );
      }
      break;

    case 803:
      {
        return Icon(
          isDay ? WeatherIcons.wi_cloudy : WeatherIcons.wi_night_cloudy,
          size: size,
          color: color,
        );
      }
      break;
    case 802:
      {
        return Icon(
          isDay ? WeatherIcons.wi_cloud : WeatherIcons.wi_night_cloudy_high,
          size: size,
          color: color,
        );
      }
      break;
    case 801:
      {
        return Icon(
          isDay ? WeatherIcons.wi_cloud : WeatherIcons.wi_night_cloudy_high,
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
