import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_3_uas_kelompok_10/features/user_auth/presentation/pages/dhasbord_page.dart';
import 'package:mobile_3_uas_kelompok_10/features/user_auth/presentation/pages/history_page.dart';
import 'package:mobile_3_uas_kelompok_10/features/user_auth/presentation/pages/home_klien_page.dart';
import 'package:mobile_3_uas_kelompok_10/features/user_auth/presentation/pages/my_profile_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _currentIndex = 0;

  double dynamicSize(double size) {
    return size;
  }

  final List<Widget> _pages = [
    const WalletHomePage(),
    const HistoryPage(),
    const DashboardPage(),
    const MyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(
            color: Colors.white,
            fontSize: dynamicSize(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1E88E5),
        elevation: 0,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color(0xFF1E88E5),
        height: dynamicSize(56),
        items: [
          Icon(Icons.home_outlined, size: dynamicSize(24), color: Colors.white),
          Icon(Icons.history, size: dynamicSize(24), color: Colors.white),
          Icon(Icons.dashboard, size: dynamicSize(24), color: Colors.white),
          Icon(Icons.perm_identity, size: dynamicSize(24), color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: const AdminHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
    ),
  );
}
