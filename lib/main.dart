import 'package:flutter/material.dart';
import 'package:flutterweather/screens/home.dart';
import 'package:flutterweather/singletons/widget_utils.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return MaterialApp(
      routes: {'': (BuildContext context) => Home()},
      onGenerateRoute: (routeSettings) =>
          NavigationUtils.onGenerateRoute(routeSettings),
    );
  }
}

class NavigationUtils {
  static onGenerateRoute(RouteSettings routeSettings) {
    return new MaterialPageRoute(
      builder: (context) {
        WidgetUtils().init(context);
        return Home();
      },
      settings: routeSettings,
    );
  }
}
