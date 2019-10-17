import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutterweather/models/current_weather.dart';
import 'package:flutterweather/painters/color_palette.dart';
import 'package:flutterweather/painters/texts.dart';
import 'package:flutterweather/presentation/weather_icons_icons.dart';
import 'package:flutterweather/singletons/widget_utils.dart';

class Sky extends CustomPainter {
  static const Color sunSettopColor = const Color.fromARGB(255, 151, 81, 213);
  static const Color sunSetbottomColor =
      const Color.fromARGB(230, 252, 220, 119);

  static const Color sunTopColor = const Color.fromARGB(255, 54, 104, 227);
  static const Color sunBottomColor =
      const Color.fromARGB(230, 251, 247, 119);

  final ui.Image image;

  Sky(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    
    /// Sky config
    var rect = Offset.zero & size;
    var sky = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter, 
      colors: ColorPallete.getSkyColors(), 
      tileMode: TileMode.clamp,
    );

    /// Sun config
    var sunRect = Offset.zero & size;
    var sun = RadialGradient(
      center: Alignment(0, -0.5),
      radius: 0.2,
      colors: [
        const Color(0xFFFFFF00), // yellow sun
        const Color.fromARGB(0, 252, 220, 119), // blue sky
      ],
      stops: [0.2, 1],
    );

    /// Draw Sky
    canvas.drawRect(
      rect,
      Paint()..shader = sky.createShader(rect),
    );

    /// Draw sun
    canvas.drawRect(
      sunRect,
      Paint()..shader = sun.createShader(rect),
    );

    /// Draw Mountains
    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
  }
    var time = DateTime.fromMillisecondsSinceEpoch(1570768433 * 1000).toLocal();


  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      var rect = Offset.zero & size;
      var width = size.shortestSide * 0.4;
      rect = const Alignment(0.8, -0.9).inscribe(Size(width, width), rect);
      return [
        CustomPainterSemantics(
          rect: rect,
          properties: SemanticsProperties(
            label: 'Sun',
            textDirection: TextDirection.ltr,
          ),
        ),
      ];
    };
  }

  @override
  bool shouldRepaint(Sky oldDelegate) => true;
  @override
  bool shouldRebuildSemantics(Sky oldDelegate) => true;
}

Future<ui.Image> _loadImage(double width) async {
  final ByteData data = await rootBundle.load('assets/images/mountain_2.png');
  if (data == null) throw 'Unable to read data';
  var codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: WidgetUtils().screenWidth.round(), targetHeight: 300);
  // add additional checking for number of frames etc here
  var frame = await codec.getNextFrame();
  return frame.image;
}

FutureBuilder<ui.Image> pictureBuilder(CurrentWeather dayForecast) {
  return FutureBuilder<ui.Image>(
      future:
          _loadImage(ui.window.physicalSize.width), // a Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Image loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              // ImageCanvasDrawer would be a (most likely) statless widget
              // that actually makes the CustomPaint etc
              return CustomPaint(
                painter: Sky(snapshot.data),
                size: Size(MediaQuery.of(context).size.width, 300),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(children: <Widget>[
                      Container(
                        child:
                            bigText(dayForecast.main.temp.round().toString()),
                        width: 100,
                        height: 150,
                      ),
                      Positioned(
                        left: 55,
                        child: Icon(WeatherIcons.wi_celsius,
                            size: 64, color: Colors.white),
                      ),
                      Positioned(
                        top: 55,
                        left: 10,
                        child: Icon(WeatherIcons.wi_day_sunny,
                            size: 64, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              );
        }
      });
}

Alignment sunPozition(int currentHour, int sunSet, int sunRise) {
  double x, y = 0;
  int dayLeght = sunSet - sunRise;
  // if (currentHour < (dayLeght / 2 + sunRise)) {
  //   x = -sqrt(1 - pow((currentHour - sunRise) / dayLeght, 2));
  // } else
  x = 0;

  y = sqrt(1 - pow(x, 2));

  // if ((currentHour - sunRise) < (dayLeght ~/ 2)) x *= -1;

  print(x.toString());
  print(y.toString());
  y *= -1;

  for (var j = 0; j < 10; j++) {
    Alignment(j / 10, j / 10);
  }

  return Alignment(x, y);
}
