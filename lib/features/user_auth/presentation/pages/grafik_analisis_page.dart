import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GrafikAnalisisAdminPage extends StatelessWidget {
  const GrafikAnalisisAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double dynamicSize(double size) => size * (screenWidth / 375);

    return Scaffold(
      appBar: AppBar(
        title: Text('Grafik Analisis', style: TextStyle(fontSize: dynamicSize(18))),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(dynamicSize(16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grafik Analisis Angsuran',
              style: TextStyle(fontSize: dynamicSize(18), fontWeight: FontWeight.bold),
            ),
            SizedBox(height: dynamicSize(16)),
            SizedBox(
              width: double.infinity,
              height: dynamicSize(300),
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: const FlTitlesData(show: true),
                  borderData: FlBorderData(show: true, border: Border.all(color: Colors.black26, width: 1)),
                  minX: 0,
                  maxX: 5,
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 20),
                        const FlSpot(1, 40),
                        const FlSpot(2, 30),
                        const FlSpot(3, 70),
                        const FlSpot(4, 50),
                        const FlSpot(5, 80),
                      ],
                      isCurved: true,
                      color: const Color.fromARGB(255, 12, 204, 98), // Single color, not a list
                      dotData: const FlDotData(show: false),
                      belowBarData: BarChartBarData(
                        show: true,
                        colors: [Colors.blueAccent.withOpacity(0.3)], // Correct usage for belowBarData
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

BarChartBarData({required bool show, required List<Color> colors}) {
}
