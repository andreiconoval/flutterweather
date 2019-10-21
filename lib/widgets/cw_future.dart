import 'package:flutter/material.dart';
import 'package:flutterweather/models/current_weather.dart';
import 'package:flutterweather/network.dart' as netw;
import 'package:flutterweather/painters/sky.dart' as painter;

FutureBuilder<CurrentWeather> getCWFutureBuilder(String cityName) {
  return FutureBuilder<CurrentWeather>(
      future: netw.fetchCurrentWeather(cityName),
      builder: (cwContext, cwSnapshot) {
        switch (cwSnapshot.connectionState) {
          case ConnectionState.done:
            if (cwSnapshot.hasError)
              return new Text('Error: ${cwSnapshot.error}');
            else if (cwSnapshot.hasData)
              return Container(
                height: 300,
                child: painter.pictureBuilder(cwSnapshot.data),
              );
            else
              return new Text('Has Data: ${cwSnapshot.hasData}');
            break;

          default:
            debugPrint("Snapshot " + cwSnapshot.toString());
            return CircularProgressIndicator(); // also check your listWidget(snapshot) as it may return null.
        }
      });
}
