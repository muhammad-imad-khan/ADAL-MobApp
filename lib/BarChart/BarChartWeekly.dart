import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'barModel.dart';

class BarChartWeekly extends StatelessWidget {
  const BarChartWeekly({Key? key}) : super(key: key);

  List<BarChartGroupData> _createSampleData() {
    final data = [
      BarModel("Mon", 16),
      BarModel("Tue", 51),
      BarModel("Wed", 21),
      BarModel("Thurs", 99),
      BarModel("Fri", 12),
      BarModel("Sat", 46),
      BarModel("Sun", 55),
    ];

    return data
        .asMap()
        .map((index, barModel) {
          return MapEntry(
            index,
            BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: barModel.value.toDouble(),
                  color: Color.fromARGB(255, 221, 97, 97),
                  width: 40,
                ),
              ],
            ),
          );
        })
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders By Weekly"),
      ),
      body: Container(
        height: 300,
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            barGroups: _createSampleData(),
            borderData: FlBorderData(
              show: false,
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    const style = TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    );
                    Widget text;
                    switch (value.toInt()) {
                      case 0:
                        text = const Text('Mon', style: style);
                        break;
                      case 1:
                        text = const Text('Tue', style: style);
                        break;
                      case 2:
                        text = const Text('Wed', style: style);
                        break;
                      case 3:
                        text = const Text('Thurs', style: style);
                        break;
                      case 4:
                        text = const Text('Fri', style: style);
                        break;
                      case 5:
                        text = const Text('Sat', style: style);
                        break;
                      case 6:
                        text = const Text('Sun', style: style);
                        break;
                      default:
                        text = const Text('', style: style);
                        break;
                    }
                    return SideTitleWidget(child: text, space: 4, axisSide: meta.axisSide);
                  },
                  reservedSize: 28,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
}