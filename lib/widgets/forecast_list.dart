import 'package:flutter/material.dart';
import 'package:flutterweather/presentation/weather_icons_icons.dart';
import 'package:intl/intl.dart';

class ContentScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          separatorBuilder:(BuildContext context, int index) => Divider(thickness: 2,  endIndent: 10,indent: 10,),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: list[index],
            );
          },
        ),
      ),
    );
  }

  final list = [
    ListTile(
      title: Center(child:Text('Today')),
      trailing: Icon(Icons.arrow_forward),
    ),
    ListTile(
      leading: Icon(Icons.wb_sunny),
      title: Text(getDate(1)),
    ),
    ListTile(
      leading: Icon(Icons.wb_sunny),
      title: Text(getDate(2)),
    ),
    ListTile(
      leading: Icon(Icons.wb_sunny),
      title: Text(getDate(3)),
    ),
    ListTile(
      leading: Icon(
        WeatherIcons.wi_cloud,
        size: 40,
      ),
      title: Text(getDate(4)),
    ),
    ListTile(
      leading: Icon(
        WeatherIcons.wi_cloud,
        size: 40,
      ),
      title: Text(getDate(4)),
    ),
    ListTile(
      leading: Icon(
        WeatherIcons.wi_cloud,
        size: 40,
      ),
      title: Text(getDate(4)),
    ),
    ListTile(
      leading: Icon(
        WeatherIcons.wi_cloud,
        size: 40,
      ),
      title: Text(getDate(4)),
    ),
  ];
}

String getDate(int day) {
  final DateTime now = DateTime.now();
  return DateFormat('HH:00 dd/mm')
      .format(now.add(Duration(hours: day)))
      .toString();
}
