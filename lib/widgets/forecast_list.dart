import 'package:flutter/material.dart';
import 'package:flutterweather/models/5_day_forecast.dart';
import 'package:flutterweather/utils/const.dart';
import 'package:flutterweather/utils/icons.dart';
import 'package:intl/intl.dart';

List<Container> getForecastList(The5Dayforecast forecast) {
  List<Container> fList = [];
  try {
    List<List<ForecastItem>> list = new List(6);
    var dtNow = DateTime.now();

    for (var i = 0; i < forecast.list.length - 1; i++) {
 
      int diffDays = forecast.list[i].dtTxt.difference(dtNow).inDays;
      var tempDt = dtNow.add(Duration(days: diffDays));
      bool isSameDay =  forecast.list[i].dtTxt.day == tempDt.day;
      if(!isSameDay) diffDays +=1;
      if (diffDays < 5) {
        if (list[diffDays] == null) list[diffDays] = [];
        list[diffDays].add(forecast.list[i]);
      }
    }

    for (var i = 0; i < 5; i++) {
      var cont = Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        color: Colors.white,
        child: ContentScroll(
          forecastItems: list[i],
        ),
      );

      fList.add(cont);
    }
  } catch (e) {
    throw Exception(e);
  }

  return fList;
}

class ContentScroll extends StatelessWidget {
  ContentScroll({Key key, this.forecastItems}) : super(key: key);

  final List<ForecastItem> forecastItems;

  @override
  Widget build(BuildContext context) {
    var list = getLists(forecastItems);
    return Container(
      child: ListView.separated(
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          thickness: 2,
          endIndent: 10,
          indent: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: list[index],
            padding: EdgeInsets.all(0),
          );
        },
      ),
    );
  }

  List<ListTile> getLists(List<ForecastItem> forecast) {
    var list = [
      ListTile(
        title: Center(
          child: Text(
            DateFormat('EEEE').format(forecast[0].dtTxt).toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        trailing: Icon(Icons.arrow_forward),
      )
    ];
    for (var i = 0; i < forecast.length; i++) {
      var tempFo = forecast[i];
      String time = DateFormat('HH:00 dd/MM').format(tempFo.dtTxt).toString();

      var tempTil = ListTile(
        leading: Container(
            child: getWheatherIcon(tempFo.weather[0].id, Colors.purple, 70, tempFo.dtTxt)),
        title: Text(
          time + ' ' + tempFo.weather[0].description,
          style: TextStyle(fontSize: 18),
        ),
        trailing: Text(
          tempFo.main.temp.round().toString() + DEGREE_SYM,
          style: TextStyle(fontSize: 22),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0),
      );
      list.add(tempTil);
    }
    return list;
  }
}

String getDate(int day) {
  final DateTime now = DateTime.now();
  return DateFormat('HH:00 dd/mm')
      .format(now.add(Duration(hours: day)))
      .toString();
}
