import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample extends StatefulWidget {
  final List<Map<DateTime, int>> list;
  LineChartSample({Key key, this.list}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartSampleState();
}

class LineChartSampleState extends State<LineChartSample> {
  StreamController<LineTouchResponse> controller;

  List<Map<DateTime, int>> list;

  @override
  void initState() {
    super.initState();
    list = widget.list;
    controller = StreamController();
    controller.stream.distinct().listen((LineTouchResponse response) {});
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            gradient: LinearGradient(
              colors: const [
                Colors.white,
                Colors.amber,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: FlChart(
                      swapAnimationDuration: Duration(milliseconds: 250),
                      chart: LineChart(sampleData1()),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
          touchResponseSink: controller.sink,
          touchTooltipData: TouchTooltipData(
            tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
          )),
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
            color: const Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 5,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '0';
              case 3:
                return '3';
              case 5:
                return '6';
              case 7:
                return '9';
              case 9:
                return '12';
              case 11:
                return '15';
              case 13:
                return '18';
              case 15:
                return '21';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '5';
              case 2:
                return '10';
              case 3:
                return '15';
              case 4:
                return '20';
              case 5:
                return '25';
            }
            return '';
          },
          margin: 8,
          reservedSize: 50,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: const Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 16,
      maxY: 7,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    return [
      const LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
          FlSpot(15, 5.2),
        ],
        isCurved: true,
        colors: [
          Color(0xff4af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      )
    ];
  }

  @override
  void dispose() {
    super.dispose();
    controller.close();
  }
}
