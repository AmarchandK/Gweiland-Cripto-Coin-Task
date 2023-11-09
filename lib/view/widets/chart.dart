
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CommonChartWidget extends StatelessWidget {
  const CommonChartWidget(
      {super.key, required this.showGradient,required this.spots, required this.color});

  // final List<Color> gradientColors = [Colors.green, Colors.green];
  final List<FlSpot> spots;
  final bool showGradient;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 6 / 1,
          child: LineChart(LineChartData(
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            minX: 0,
            maxX: 11,
            minY: 0,
            maxY: 8,
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                  
                isCurved: true,
                color: color,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(show: showGradient, color: color),
              ),
            ],
          )),
        ),
      ],
    );
  }
}
