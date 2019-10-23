import 'package:flutter/material.dart';
import 'package:flutterweather/models/5_day_forecast.dart';
import 'package:flutterweather/models/city.dart';
import 'package:flutterweather/widgets/forecast_list.dart';

import '../network.dart';

FutureBuilder<The5Dayforecast> getWFutureBuilder(City city) {
  return FutureBuilder<The5Dayforecast>(
    future: fetchWeatherForecast(city.name),
    builder: (wfcontext, wfsnapshot) {
      switch (wfsnapshot.connectionState) {
        case ConnectionState.done:
          if (wfsnapshot.hasError)
            return new Text('Error: ${wfsnapshot.error}');
          else if (wfsnapshot.hasData)
            return Container(
              child: PageView(
                controller: PageController(viewportFraction: 0.9),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                children: getForecastList(wfsnapshot.data),
              ),
            );
          else
            return new Text('Has Data: ${wfsnapshot.hasData}');
          break;

        default:
          debugPrint("Snapshot " + wfsnapshot.toString());
          return Center(
              child: Container(
            child: CircularProgressIndicator(),
            height: 50,
            width: 50,
          )); // also check your listWidget(snapshot) as it may return null.
      }
    },
  );
}
