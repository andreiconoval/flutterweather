import 'package:flutter/material.dart';
import 'package:flutterweather/models/5_day_forecast.dart';
import 'package:flutterweather/painters/color_palette.dart';
import 'package:flutterweather/widgets/forecast_list.dart';
import 'package:intl/intl.dart';

import 'package:flutterweather/models/current_weather.dart';
import 'package:flutterweather/painters/sky.dart';
import 'package:flutterweather/widgets/search_box.dart';
import 'package:flutterweather/network.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home(currentWeather: fetchCurrentWeather('sss'));
}

class _Home extends State<Home> {
  final Future<CurrentWeather> currentWeather;

  _Home({Key key, this.currentWeather}) : super();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPallete.getSkyColors()[0],
          elevation: 0.0,
          title: Center(child: Text('Craiova')),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            )
          ],
        ),
        drawer: Drawer(),
        body: Column(children: [
          Container(
            child: FutureBuilder<CurrentWeather>(
                future: currentWeather,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else if (snapshot.hasData)
                        return Container(
                          height: 300,
                          child: pictureBuilder(snapshot.data),
                        );
                      else
                        return new Text('Has Data: ${snapshot.hasData}');
                      break;

                    default:
                      debugPrint("Snapshot " + snapshot.toString());
                      return CircularProgressIndicator(); // also check your listWidget(snapshot) as it may return null.
                  }
                }),
          ),
          Expanded(
              child: FutureBuilder<The5Dayforecast>(
            future: fetchWeatherForecast('sss'),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else if (snapshot.hasData)
                    return Container(
                      child: PageView(
                        controller: PageController(viewportFraction: 0.9),
                        scrollDirection: Axis.horizontal,
                        pageSnapping: true,
                        children: getForecastList(snapshot.data),
                      ),
                    );
                  else
                    return new Text('Has Data: ${snapshot.hasData}');
                  break;

                default:
                  debugPrint("Snapshot " + snapshot.toString());
                  return CircularProgressIndicator(); // also check your listWidget(snapshot) as it may return null.
              }
            },
          )),
          //ContentScroll(),
        ]),
      ),
    );
  }
}

String getDate(int day) {
  final DateTime now = DateTime.now();
  return DateFormat('dd MMMM').format(now.add(Duration(days: day))).toString();
}
