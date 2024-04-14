import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FLchart extends StatefulWidget {
  const FLchart({super.key});

  @override
  State<FLchart> createState() => _FLchartState();
}

class _FLchartState extends State<FLchart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
        AspectRatio(
        aspectRatio: 2,
        child: LineChart(
          LineChartData(
            rangeAnnotations: RangeAnnotations(
              verticalRangeAnnotations: [
              VerticalRangeAnnotation(
              x1: 0,
              x2: 8,
            )
              ]),
            lineBarsData: [
              LineChartBarData(
                spots: data.map((point) => FlSpot(point.x, point.y)).toList(),
                isCurved: false,
                // dotData: FlDotData(
                //   show: false,
                // ),
              ),
            ],
          ),
        ),
      )
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget SideTitlesWidget(double value ,TitleMeta meta){
    Color colors;
   String? text;

    switch(value.toInt()){
      case 0:
        text='0';
        break;
      case 1:
        text='0';
        break;
      case 2:
        text='0';
        break;

      case 3:
        text='0';
        break;
      case 4:
        text='0';
        break; case 0:
      text='0';
      break;

  }

    return SideTitleWidget(
        child: Text(
          text!,
        ),
        axisSide: meta.axisSide);
  }
}


final data = [
  DataPoint(0, 4.5),
  DataPoint(1, 6.0),
  DataPoint(2, 7.5),
  DataPoint(3, 3.0),
  DataPoint(4, 5.0),
  DataPoint(5, 6.0),
  DataPoint(6, 3.0),
];


class DataPoint {
  final double x;
  final double y;

  DataPoint(this.x, this.y);
}