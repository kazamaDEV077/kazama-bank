import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';

class PinjamanKlienPage extends StatelessWidget {
  const PinjamanKlienPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pinjaman Klien'),
        backgroundColor: Colors.purpleAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circular Progress Indicator
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 10.0,
                  percent: 0.71,
                  center: const Text(
                    "71%",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  progressColor: Colors.purpleAccent,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Statistik Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatisticCard(
                  context,
                  "Total Pinjaman",
                  "Rp 25,000,000",
                  Colors.blue,
                  null, // Tidak ada onTap
                ),
                _buildStatisticCard(
                  context,
                  "Terkumpul",
                  "Rp 15,000,000",
                  Colors.green,
                  null, // Tidak ada onTap
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Grafik Line
            const Text(
              "Statistik Bulanan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: true),
                    titlesData: const FlTitlesData(show: true),
                    borderData: FlBorderData(show: true),
                    minX: 0,
                    maxX: 11,
                    minY: 0,
                    maxY: 20,
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.purpleAccent,
                        barWidth: 4,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              Colors.purpleAccent.withOpacity(0.3),
                              Colors.purpleAccent.withOpacity(0.1),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        spots: [
                          const FlSpot(0, 3),
                          const FlSpot(2, 5),
                          const FlSpot(4, 8),
                          const FlSpot(6, 12),
                          const FlSpot(8, 15),
                          const FlSpot(10, 18),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Detail Pinjaman
            const Text(
              "Detail Pinjaman",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildLoanListTile("Mongky D LUttdy", "Disetujui", "Rp 10,000,000"),
            const Divider(),
            _buildLoanListTile("Roronoa Zoro", "Menunggu Persetujuan", "Rp 15,000,000"),
            const Divider(),
            _buildLoanListTile("SANji ozawa", "Ditolak", "Rp 8,000,000"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard(
    BuildContext context,
    String title,
    String value,
    Color color,
    VoidCallback? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: color.withOpacity(0.1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14, color: color),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoanListTile(String title, String status, String amount) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("Status: $status"),
      trailing: Text(
        amount,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
  }
}
