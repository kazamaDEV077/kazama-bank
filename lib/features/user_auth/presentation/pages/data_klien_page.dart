import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class DataKlienPage extends StatelessWidget {
  final List<Map<String, dynamic>> klienData;

  DataKlienPage({super.key})
      : klienData = List.generate(10, (index) {
          final random = Random();
          final joinDate = DateTime.now().subtract(Duration(days: random.nextInt(365)));
          return {
            "name": "Klien ${['Ayu', 'Budi', 'Citra', 'Dewi', 'Eka', 'Fajar', 'Gita', 'Hadi', 'Indra', 'Joko'][index]}",
            "email": "klien${index + 1}@example.com",
            "joinDate": joinDate,
            "loan": random.nextInt(50000000) + 5000000, 
            "installment": random.nextInt(48) + 12, 
          };
        });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Klien', style: TextStyle(color: Colors.red)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.red),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          // Grafik Analisis Klien
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AspectRatio(
              aspectRatio: 1.7,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  borderData: FlBorderData(show: true, border: Border.all(color: Colors.red, width: 1)),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        10,
                        (index) => FlSpot(index.toDouble(), Random().nextDouble() * 10),
                      ),
                      isCurved: true,
                      color: Colors.redAccent,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(show: false),
                      dotData: const FlDotData(show: false),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: klienData.length,
              itemBuilder: (context, index) {
                final klien = klienData[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailKlienPage(klien: klien),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red.shade100,
                        child: const Icon(Icons.person, color: Colors.redAccent),
                      ),
                      title: Text(
                        klien["name"],
                        style: const TextStyle(color: Colors.red),
                      ),
                      subtitle: Text(
                        klien["email"],
                        style: const TextStyle(color: Colors.black54),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailKlienPage extends StatelessWidget {
  final Map<String, dynamic> klien;

  const DetailKlienPage({super.key, required this.klien});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Klien', style: TextStyle(color: Colors.red)),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red.shade100,
                        radius: 40,
                        child: const Icon(Icons.person, color: Colors.redAccent, size: 40),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      klien["name"],
                      style: const TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Email:',
                    style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    klien["email"],
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tanggal Bergabung:',
                    style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    klien["joinDate"].toLocal().toString().split(' ')[0],
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Pinjaman:',
                    style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rp${klien["loan"].toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}',
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Durasi Angsuran:',
                    style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${klien["installment"]} bulan',
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.red,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
      ),
    ),
    home: DataKlienPage(),
  ));
}
