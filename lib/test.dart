// import 'package:syncfusion_flutter_charts/charts.dart';
//
// class MulticolorCategoryAxis extends CategoryAxis {
//   MulticolorCategoryAxis({
//     required List<ChartData> dataSource,
//     required CategoryValueMapper<ChartData, String> categoryValueMapper,
//   }) : super(
//     dataSource: dataSource,
//     categoryValueMapper: categoryValueMapper,
//   );
//
//   @override
//   AxisLabelStyle GetLabelStyle(
//       ChartAxisLabel label,
//       AxisLabelRenderDetails renderDetails,
//       ) {
//     final ChartData data = renderDetails.dataPoints[renderDetails.pointIndex];
//     return AxisLabelStyle(
//       color: data.color,
//       // You can also customize other properties like font size, font weight, etc.
//       // fontFamily: 'MyCustomFont',
//       // fontSize: 12,
//       // fontWeight: FontWeight.bold,
//     );
//   }
// }