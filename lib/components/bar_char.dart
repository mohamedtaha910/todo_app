import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({
    super.key,
    required this.completedTasks,
    required this.pendingTasks, required this.totalTasks,

  });
  final double completedTasks;
  final double pendingTasks;
  final double totalTasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 24),

      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),

      child: BarChart(

        BarChartData(
          maxY: totalTasks,
          barGroups: [
            BarChartGroupData(
              barsSpace: 28,
              x: 0,

              barRods: [
                BarChartRodData(
                  toY: completedTasks,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: Colors.green,
                  width: 30,
                ),
                BarChartRodData(
                  toY: pendingTasks,
                  color: Colors.pinkAccent,
                  width: 30,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
