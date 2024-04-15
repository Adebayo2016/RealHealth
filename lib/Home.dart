import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class Home extends StatefulWidget  {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController? _tabController;

  late TooltipBehavior _tooltipBehavior;
  List<ChartData>? chartData;
  ChartPointDetails? _chartPointDetails;
  DateTime _currentDate = DateTime(2024, 1, 1);



  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController?.addListener(_handleTabSelection);
    _tooltipBehavior = TooltipBehavior(enable: true);
    getChartData();
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }


  void _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      setState(() {
        switch (_tabController?.index) {
          case 0:
            _currentDate = DateTime(2024, 1, 1);
            break;
          case 1:
            _currentDate = DateTime(2024, 4, 1);
            break;
          case 2:
            _currentDate = DateTime(2024, 1, 1);
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Real health Chart')),
        body:Column(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Real health'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back_ios_new
                      ),
                      SizedBox(width: 10,),
                      Text('${DateFormat('MMM yyyy').format(_currentDate)} - ${DateFormat('MMM yyyy').format(DateTime(2024, 12, 31))}'),

                      SizedBox(width: 10,),
                      Icon(Icons.arrow_forward_ios
                      ),
                    ],
                  )
                ],
              ),

            ),
              Container(
                child: TabBar(
                indicatorWeight: 3,
                controller: _tabController,
                labelStyle: const TextStyle(
                  fontSize: 12, color: Colors.black,
                  fontWeight: FontWeight.w500,
                  //  fontFamily: TRENDA_SEMI_BOLD,
                ),
                tabs: [
                  Tab(text: 'LATEST'),
                  Tab(text: 'QUARTER'),
                  Tab(text: 'YEAR'),
                ],
                            ),
              ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildLatestTab(),
              _buildQuarterTab(),
              _buildYearTab(),
            ],
          ),
        )
    ],

        ));

  }
  List<ChartData> getChartData() {
    return [
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y, this.additionalData,this.color, this.imageList,)
      : this.image = _randomImage(imageList);

  final String x;
  final double y;
  final String additionalData;
  final Color color;
  final ImageProvider image;
  final List<ImageProvider> imageList;
  static ImageProvider _randomImage(List<ImageProvider> imageList) {
    return imageList[Random().nextInt(imageList.length)];
  }
}

// class CustomCategoryAxis extends CategoryAxis {
//   CustomCategoryAxis({
//     required List<ChartData> dataSource,
//     required XValueMapper<ChartData, String> xValueMapper,
//     required CategoryMapper<ChartData, String> categoryMapper,
//   }) : super(
//     dataSource: dataSource,
//     xValueMapper: xValueMapper,
//     categoryMapper: categoryMapper,
//   );
//
//   @override
//   AxisLabelStyle GetLabelStyle(
//       ChartAxisLabel label,
//       AxisLabelRenderDetails renderDetails,
//       ) {
//     final DDASData data = renderDetails.dataPoints[renderDetails.pointIndex];
//     return AxisLabelStyle(color: data.color);
//   }
// }
Widget _buildLatestTab() {
  final List<ImageProvider> markerImages = [
    AssetImage('assets/images/green.png'),
    AssetImage('assets/images/blue.png'),
    // Add other images...
  ];
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        tooltipBehavior: TooltipBehavior(
          enable: true,
          builder: (dynamic data, dynamic point, dynamic series,
              int pointIndex, int seriesIndex) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                  height: 200,
                  width :150,
                  decoration: BoxDecoration(
                  ),
                  child: Column(
                    children: [
                      Text("Tuesday, 1st January 2024",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      SizedBox(height:5),
                      Text((data as ChartData).additionalData),
                    ],
                  )),
            );
          },
        ),
        primaryXAxis: CategoryAxis(
          labelPlacement: LabelPlacement.onTicks,
          interval: 1,
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(size: 0),
          labelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 10,
          interval: 2.5,
          majorGridLines: MajorGridLines(
              width: 1, color: Colors.grey.withOpacity(0.5)),
          majorTickLines: MajorTickLines(size: 0),
          axisLabelFormatter:(AxisLabelRenderDetails details) {
            final value = details.value;
            Color? color;
            switch (value.toInt()) {
              case 0:
                color = Colors.red;
                break;
              case 2.5:
                color = Colors.green;
                break;
              case 5:
                color = Colors.blue;
                break;
              case 7.5:
                color = Colors.black;
                break;
              case 10:
                color = Colors.pink;
                break;
            }
            return ChartAxisLabel(value.toString(), TextStyle(color: color,
                fontSize: 12
            ));
          },

        ),
        series: <CartesianSeries<ChartData, String>>[
          LineSeries<ChartData, String>(
            enableTooltip: true,
            dataSource: [
              ChartData(
                  '1St',
                  10,
                  'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                  Colors.red, markerImages ),
              ChartData(
                  '8th',
                  5,
                  'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                  Colors.green,markerImages),
              ChartData(
                  '15th',
                  4,
                  'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                  Colors.orange,markerImages),
              ChartData(
                  '20th',
                  3,
                  'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                  Colors.blue,markerImages),
              ChartData(
                  '25th',
                  6.0,
                  'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                  Colors.green,markerImages),
              ChartData(
                  '28th',
                  6.5,
                  'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                  Colors.red,markerImages),
              ChartData(
                  '30th',
                  7.0,
                  'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                  Colors.blue,markerImages),

            ],
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            pointColorMapper: (ChartData data, _) => data.color,
            color: Colors.grey,
            width: 1,
            markerSettings: MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              //color:
              // borderColor: Colors.blue,
              borderWidth: 1,
            ),

          ),

        ],
      ),
    ),
  );
}

Widget _buildQuarterTab() {

  final List<AssetImage> markerImages = [
    AssetImage('assets/images/green.png'),
    AssetImage('assets/images/blue.png'),
  ];
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              tooltipBehavior: TooltipBehavior(
                enable: true,
                builder: (dynamic data, dynamic point, dynamic series,
                    int pointIndex, int seriesIndex) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  child: Container(
                      height: 200,
                      width :150,
                      decoration: BoxDecoration(
                      ),
                      child: Column(
                        children: [
                          Text("Tuesday, 2nd January 2024",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          SizedBox(height:5),
                          Text((data as ChartData).additionalData),
                        ],
                      )),
                  );
                },
              ),
              primaryXAxis: CategoryAxis(
                labelPlacement: LabelPlacement.onTicks,
                interval: 1,
                majorGridLines: MajorGridLines(width: 0),
                majorTickLines: MajorTickLines(size: 0),
                labelStyle: TextStyle(
                  color: Colors.black,
                ),

              ),

              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 10,
                interval: 2,
                majorGridLines: MajorGridLines(
                    width: 0.5, color: Colors.grey.withOpacity(0.5)),
                majorTickLines: MajorTickLines(size: 0),
                axisLabelFormatter:(AxisLabelRenderDetails details) {
                  final value = details.value;
                  Color? color;
                  switch (value.toInt()) {
                    case 0:
                      color = Colors.red;
                      break;
                    case 2.5:
                      color = Colors.green;
                      break;
                    case 5:
                      color = Colors.blue;
                      break;
                    case 7.5:
                      color = Colors.black;
                      break;
                    case 10:
                      color = Colors.pink;
                      break;
                  }
                  return ChartAxisLabel(value.toString(), TextStyle(color: color,
                  fontSize: 12
                  ));
                },

              ),
              series: <CartesianSeries<ChartData, String>>[
                LineSeries<ChartData, String>(
                  enableTooltip: true,
                  dataSource: [
                    ChartData(
                        '1St',
                        10,
                        'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                        Colors.red,markerImages),
                    ChartData(
                        '8th',
                        5,
                        'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                        Colors.green,markerImages),
                    ChartData(
                        '15th',
                        4,
                        'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                        Colors.orange,markerImages),
                    ChartData(
                        '20th',
                        3,
                        'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                        Colors.blue,markerImages),
                    ChartData(
                        '25th',
                        6.0,
                        'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                        Colors.green,markerImages),
                    ChartData(
                        '28th',
                        6.5,
                        'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                        Colors.red,markerImages),
                    ChartData(
                        '30th',
                        7.0,
                        'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
                        Colors.blue,markerImages),
                  ],
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                 // pointColorMapper: (ChartData data, _) => data.color,
                  color: Colors.grey,
                  width: 1,
                  markerSettings: MarkerSettings(
                    isVisible: true,
                    shape: DataMarkerType.image,
                    image: AssetImage('assets/images/blue.png'),
                    borderWidth: 1,
                    height: 15,
                    width: 15,
                  ),

                ),

              ],
            ),
          ),
        ),

      ],
    ),
  );
}

Widget _buildYearTab() {
  
  final List<ImageProvider> markerImages = [
    AssetImage('assets/images/green.png'),
    AssetImage('assets/images/blue.png'),
    // Add other images...
  ];

  Color? getMarkerColor(ChartData data, int pointIndex, int seriesIndex, double pointX) {
    if (pointIndex > 4) {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }


  ImageProvider<Object>? getMarkerImage(
      ChartData data,
      int pointIndex,
      int seriesIndex,
      double pointX,
      ) {
    return pointIndex > 4 ? markerImages[0] : markerImages[1];
  }
  
  final List<ChartData> chartData = [
    ChartData(
      'JAN',
      10,
      'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
      Colors.red,
      markerImages,
    ),
    ChartData(
      'FEB',
      5,
      'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
      Colors.green,
      markerImages,
    ),
    ChartData(
      'MAR',
      4,
      'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
      Colors.orange,
      markerImages,
    ),
    ChartData(
      'APR',
      3,
      'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
      Colors.blue,
      markerImages,
    ),
    ChartData(
      'MAY',
      6.0,
      'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
      Colors.green,
      markerImages,
    ),
    ChartData(
      'JUN',
      6.5,
      'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
      Colors.red,
      markerImages,
    ),
    ChartData(
      'JUL',
      7.0,
      'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
      Colors.blue,
      markerImages,
    ),
  ];


  List<LineSeries<ChartData, String>> lineSeriesList = [];
  lineSeriesList.add(
    LineSeries<ChartData, String>(
      enableTooltip: true,
      dataSource: chartData,
      xValueMapper: (ChartData data, _) => data.x,
      yValueMapper: (ChartData data, _) => data.y,
      pointColorMapper:  (ChartData data, _) => data.color,
      color: Colors.grey,
      width: 1,
      markerSettings: MarkerSettings(
        isVisible: true,
        shape: DataMarkerType.circle,
        //color: getMarkerColor,
        //image:(ChartData data, _) => data.image,
        borderWidth: 1,
        height: 15,
          width: 15
      ),
    ),
  );

  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              tooltipBehavior: TooltipBehavior(
                enable: true,
                builder: (dynamic data, dynamic point, dynamic series,
                    int pointIndex, int seriesIndex) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      height: 200,
                      width :150,
                      decoration: BoxDecoration(
                      ),
                        child: Column(
                          children: [
                            Text("Tuesday, 1st January 2024",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                            )
                            ),
                            SizedBox(height:5),
                            Text((data as ChartData).additionalData),
                          ],
                        )),
                  );
                },
              ),
              primaryXAxis: CategoryAxis(
                labelPlacement: LabelPlacement.onTicks,
                interval: 1,
                majorGridLines: MajorGridLines(width: 0),
                majorTickLines: MajorTickLines(size: 0),
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 10,
                interval: 2.5,
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
                majorGridLines: MajorGridLines(
                  width: 1,
                  color: Colors.grey.withOpacity(0.5),
                ),
                majorTickLines: MajorTickLines(size: 0),
                axisLabelFormatter: (AxisLabelRenderDetails details) {
                  final value = details.value;
                  Color? color;
                  switch (value.toInt()) {
                    case 0:
                      color = Colors.red;
                      break;
                    case 2.5:
                      color = Colors.green;
                      break;
                    case 5:
                      color = Colors.blue;
                      break;
                    case 7.5:
                      color = Colors.black;
                      break;
                    case 10:
                      color = Colors.pink;
                      break;
                  }
                  return ChartAxisLabel(value.toString(), TextStyle(color: color));
                },
              ),
              series: lineSeriesList,
            ),
          ),
        ),
      ],
    ),
  );
}
// Widget _buildYearTab() {
//
//   final List<ImageProvider> markerImages = [
//     AssetImage('assets/images/green.png'),
//     AssetImage('assets/images/blue.png'),
//     // Add other images...
//   ];
//
//   final List<ChartData> chartData = [
//           ChartData(
//               'JAN',
//               10,
//               'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               Colors.red,markerImages),
//           ChartData(
//               'FEB',
//               5,
//               'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               Colors.green,markerImages),
//           ChartData(
//               'MAR',
//               4,
//               'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               Colors.orange,markerImages),
//           ChartData(
//               'APR',
//               3,
//               'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               Colors.blue,markerImages),
//           ChartData(
//               'MAY',
//               6.0,
//               'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               Colors.green,markerImages),
//           ChartData(
//               'JUN',
//               6.5,
//               'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               Colors.red,markerImages),
//           ChartData(
//               'JUL',
//               7.0,
//               'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               Colors.blue,markerImages)
//   ];
//
//   List<LineSeries<ChartData, String>> lineSeriesList = [];
//
//   for (var i = 0; i < chartData.length; i++) {
//     lineSeriesList.add(
//       LineSeries<ChartData, String>(
//         enableTooltip: true,
//         dataSource: [chartData[i]],
//         xValueMapper: (ChartData data, _) => data.x,
//         yValueMapper: (ChartData data, _) => data.y,
//         color: Colors.grey,
//         width: 1,
//         markerSettings: MarkerSettings(
//           isVisible: true,
//           shape: DataMarkerType.image,
//           image: i > 4 ? markerImages[0] : markerImages[1],
//           borderWidth: 1,
//         ),
//       ),
//     );
//   }
//
//
//
//   return Center(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SfCartesianChart(
//               plotAreaBorderWidth: 0,
//               tooltipBehavior: TooltipBehavior(
//                 enable: true,
//                 builder: (dynamic data, dynamic point, dynamic series,
//                     int pointIndex, int seriesIndex) {
//                   return Container(
//                     padding: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(4.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Text((data as ChartData).additionalData),
//                   );
//                 },
//               ),
//               primaryXAxis: CategoryAxis(
//                 labelPlacement: LabelPlacement.onTicks,
//                 interval: 1,
//                 majorGridLines: MajorGridLines(width: 0),
//                 majorTickLines: MajorTickLines(size: 0),
//                 labelStyle: TextStyle(
//                   color: Colors.black,
//                 ),
//               ),
//               primaryYAxis:
//               NumericAxis(
//                 minimum: 0,
//                 maximum: 10,
//                 interval: 2.5,
//                 isVisible: true,
//                 labelPosition: ChartDataLabelPosition.outside,
//                 majorGridLines: MajorGridLines(
//                   width: 1,
//                   color: Colors.grey.withOpacity(0.5),
//                 ),
//                 majorTickLines: MajorTickLines(size: 0),
//                 axisLabelFormatter:(AxisLabelRenderDetails details) {
//                   final value = details.value;
//                   Color? color;
//                   switch (value.toInt()) {
//                     case 0:
//                       color = Colors.red;
//                       break;
//                     case 2.5:
//                       color = Colors.green;
//                       break;
//                     case 5:
//                       color = Colors.blue;
//                       break;
//                     case 7.5:
//                       color = Colors.black;
//                       break;
//                     case 10:
//                       color = Colors.pink;
//                       break;
//                   }
//                   return ChartAxisLabel(value.toString(), TextStyle(color: color));
//                 },
//
//               ),
//
//               series:lineSeriesList,
//               // <CartesianSeries<ChartData, String>>[
//               //   LineSeries<ChartData, String>(
//               //     enableTooltip: true,
//               //     dataSource: [
//               //       ChartData(
//               //           'JAN',
//               //           10,
//               //           'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               //           Colors.red,markerImages),
//               //       ChartData(
//               //           'FEB',
//               //           5,
//               //           'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               //           Colors.green,markerImages),
//               //       ChartData(
//               //           'MAR',
//               //           4,
//               //           'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               //           Colors.orange,markerImages),
//               //       ChartData(
//               //           'APR',
//               //           3,
//               //           'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               //           Colors.blue,markerImages),
//               //       ChartData(
//               //           'MAY',
//               //           6.0,
//               //           'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               //           Colors.green,markerImages),
//               //       ChartData(
//               //           'JUN',
//               //           6.5,
//               //           'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               //           Colors.red,markerImages),
//               //       ChartData(
//               //           'JUL',
//               //           7.0,
//               //           'Overall score: 7, Health score: 3, Patient tender count: 7, Patient swollen count: 6, ROM swollen: 8',
//               //           Colors.blue,markerImages),
//               //     ],
//               //     xValueMapper: (ChartData data, _) => data.x,
//               //     yValueMapper: (ChartData data, _) => data.y,
//               //     pointColorMapper: (ChartData data, _) => data.color,
//               //     color: Colors.grey,
//               //     width: 1,
//               //
//               //     markerSettings: MarkerSettings(
//               //       isVisible: true,
//               //       shape: DataMarkerType.image,
//               //       borderColor: Colors.blue,
//               //       borderWidth: 1,
//               //       image:
//               //
//               //     ),
//               //   ),
//               // ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
List<Color> labelColors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.blue,
  Colors.red,
  Colors.blue,
];







ChartAxis PrimaryYAxiss(double value){
  Color? colors;
  switch(value.toInt()){
    case 0:
      colors=Colors.red;
      break;

    case 1:
      colors=Colors.green;

    case 2:
      colors=Colors.red;
      break;
    case 3:
      colors=Colors.black;
      break;

    case 4:
      colors=Colors.pink;
      break;

  }

  return NumericAxis(
      minimum: 0,
      maximum: 10,
      interval: 2.5,
      isVisible: true,
      labelPosition: ChartDataLabelPosition.outside,
      // visibleLabels: [ // Customize visible labels here
      //   ChartAxisLabel(axisValue: 2.5, label: '2.5'),
      //   ChartAxisLabel(axisValue: 5, label: '5.0'),
      //   ChartAxisLabel(axisValue: 7.5, label: '7.5'),
      //   ChartAxisLabel(axisValue: 10, label: '10.0'),
      // ],

      majorGridLines: MajorGridLines(
          width: 1, color: Colors.grey.withOpacity(0.5)),
      majorTickLines: MajorTickLines(size: 0),
      labelStyle: TextStyle(
        color: colors,
      ),
    );

}
Color? getMarkerColor(ChartData data, _) => data.color;
final markerColors = [Colors.red, Colors.green, Colors.blue, Colors.black, Colors.pink];


Widget filledCircleMarkerBuilder(
    ChartSeriesRenderer seriesRenderer, int pointIndex, PointInfo<dynamic> point) {
  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/blue.png'),
        fit: BoxFit.contain,
      ),
    ),
  );
}




// class CustomCircleMarkerRenderer extends ChartSeriesRenderer {
//   CustomCircleMarkerRenderer();
//
//   @override
//   void drawPoint(
//       ChartCanvas canvas,
//       Size size,
//       List<Offset?> points,
//       int pointIndex,
//       int seriesIndex,
//       SfCartesianChart chart,
//       CartesianSeriesRenderer seriesRenderer,
//       ) {
//     final ChartData data = seriesRenderer.series.dataSource![pointIndex];
//
//     final Paint paint = Paint()
//       ..color = data.color
//       ..style = PaintingStyle.fill;
//
//     canvas.drawCircle(points[0]!, 5, paint); // Adjust the radius as needed
//   }
//
//   @override
//   ChartSegment createSegment() {
//     // TODO: implement createSegment
//     throw UnimplementedError();
//   }
//
//   @override
//   void customizeSegment(ChartSegment segment) {
//     // TODO: implement customizeSegment
//   }
// }