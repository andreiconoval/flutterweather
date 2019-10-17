import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterweather/presentation/weather_icons_icons.dart';

Text bigText(String text) {
  return Text(text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 66,
        fontWeight: FontWeight.bold,
        
      ),);
}

Icon weatherIcon(WeatherIcons icon){
  return Icon(WeatherIcons.wi_celsius);
}
