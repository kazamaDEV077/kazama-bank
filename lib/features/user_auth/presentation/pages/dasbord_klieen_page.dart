import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'angsuran_klien_page.dart';
import 'pinjaman_klien_page.dart';
import 'history_page.dart';
import 'data_klien_page.dart';
import 'tambah_anggota_klien_page.dart';

class DashboardClientPage extends StatefulWidget {
  const DashboardClientPage({super.key});

  @override
  _DashboardClientPageState createState() => _DashboardClientPageState();
}

class _DashboardClientPageState extends State<DashboardClientPage> {
  final List<Map<String, dynamic>> _features = [
    {
      'title': 'Tambah Anggota',
      'icon': Icons.group_add,
      'color': Colors.yellowAccent,
      'page': TambahAnggotaKlienPage(),
    },
    {
      'title': 'Angsuran Klien',
      'icon': Icons.payment,
      'color': const Color.fromARGB(255, 243, 164, 16),
      'page': const AngsuranKlienPage(),
    },
    {
      'title': 'Pinjaman Klien',
      'icon': Icons.attach_money,
      'color': const Color.fromARGB(255, 228, 1, 248),
      'page': const PinjamanKlienPage(),
    },
    {
      'title': 'History',
      'icon': Icons.history,
      'color': const Color.fromARGB(255, 1, 197, 138),
      'page': const HistoryPage(),
    },
    {
      'title': 'Data Klien',
      'icon': Icons.folder,
      'color': Colors.redAccent,
      'page': DataKlienPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Klien'),
        backgroundColor: const Color.fromARGB(255, 28, 49, 238),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoSection(),
            const SizedBox(height: 20),
            _buildAnalyticsChart(),
            const SizedBox(height: 20),
            _buildFeatureList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      color: const Color.fromARGB(255, 19, 51, 235),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoCard('Anggota', '50', Icons.people),
          _buildInfoCard('Bergabung', '45', Icons.how_to_reg),
          _buildInfoCard('Transaksi', '120', Icons.swap_horiz),
          _buildInfoCard('sesuianggaran', '98%', Icons.check_circle),
        ],
      ),
    );
  }

  Widget _buildAnalyticsChart() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 200,
          child: BarChart(
            BarChartData(
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [BarChartRodData(toY: 50, color: const Color.fromARGB(255, 31, 60, 223))],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [BarChartRodData(toY: 45, color: Colors.greenAccent)],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [BarChartRodData(toY: 120, color: Colors.purpleAccent)],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [BarChartRodData(toY: 98, color: Colors.orangeAccent)],
                ),
              ],
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return const Text('Anggota');
                        case 1:
                          return const Text('Bergabung');
                        case 2:
                          return const Text('Transaksi');
                        case 3:
                          return const Text('Sesuai');
                        default:
                          return const Text('');
                      }
                    },
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: _features.map((feature) {
          return _buildFeatureTile(
            title: feature['title'],
            icon: feature['icon'],
            color: feature['color'],
            onTap: () => _navigateWithTransition(context, feature['page']),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeatureTile({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: color.withOpacity(0.8),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 40, color: Colors.white),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  void _navigateWithTransition(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DashboardClientPage(),
  ));
}
