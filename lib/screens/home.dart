import 'package:flutter/material.dart';
import 'package:flutterweather/widgets/wf_future.dart';
import 'package:intl/intl.dart';

import 'package:flutterweather/models/user_config.dart';
import 'package:flutterweather/painters/color_palette.dart';
import 'package:flutterweather/utils/assets_manager.dart';
import 'package:flutterweather/widgets/cw_future.dart';
import 'package:flutterweather/widgets/search_box.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  _Home({Key key}) : super();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder<UserConfig>(
      future: loadUserConfig(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else {
              print('Has Data: ${snapshot.hasData}');
              if (snapshot.hasData)
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: ColorPallete.getSkyColors()[0],
                    elevation: 0.0,
                    title: Center(child: Text(snapshot.data.defaultCity.name)),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(context: context, delegate: DataSearch(cities: snapshot.data.searchedCities));
                        },
                      )
                    ],
                  ),
                  drawer: Drawer(),
                  body: Column(children: [
                    Container(
                        child:
                            getCWFutureBuilder(snapshot.data.defaultCity.name)),
                    Expanded(
                        child:
                            getWFutureBuilder(snapshot.data.defaultCity.name)),
                    //ContentScroll(),
                  ]),
                );
              else
                return new Text('Has Data: : ${snapshot.hasData}');
            }
            break;

          default:
            debugPrint("Snapshot " + snapshot.toString());
            return CircularProgressIndicator(); // also check your listWidget(snapshot) as it may return null.
        }
      },
    ));
  }
}

String getDate(int day) {
  final DateTime now = DateTime.now();
  return DateFormat('dd MMMM').format(now.add(Duration(days: day))).toString();
}
