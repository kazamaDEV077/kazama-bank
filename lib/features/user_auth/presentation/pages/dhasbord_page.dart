import 'package:flutter/material.dart';
import 'tambah_anggota_page.dart';
import 'tambah_angsuran_page.dart';
import 'data_pinjaman_page.dart';
import 'data_angsuran_page.dart';
import 'history_page.dart';
import 'kelola_angsuran_page.dart';
import 'kelola_pinjaman_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menu items
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Tambah Anggota',
        'icon': Icons.person_add,
        'color': Colors.greenAccent,
        'page': TambahAnggotaPage(
          onSave: (data) {
            print('Data anggota disimpan: $data');
          },
          onAddAnggota: (data) {
            print('Anggota ditambahkan: $data');
          },
        ),
      },
      {
        'title': 'Tambah Angsuran',
        'icon': Icons.add_box,
        'color': Colors.orangeAccent,
        'page': TambahAngsuranPage(
          onSave: (data) {
            print('Data angsuran disimpan: $data');
          },
        ),
      },
      {
        'title': 'Data Pinjaman',
        'icon': Icons.monetization_on,
        'color': Colors.blueAccent,
        'page': const DataPinjamanPage(),
      },
      {
        'title': 'Data Angsuran',
        'icon': Icons.receipt_long,
        'color': Colors.purpleAccent,
        'page': const DataAngsuranPage(),
      },
      {
        'title': 'History',
        'icon': Icons.history,
        'color': Colors.brown,
        'page': const HistoryPage(),
      },
      {
        'title': 'Kelola Angsuran',
        'icon': Icons.manage_accounts,
        'color': Colors.redAccent,
        'page': const KelolaAngsuranPage(),
      },
      {
        'title': 'Kelola Pinjaman',
        'icon': Icons.book,
        'color': Colors.tealAccent,
        'page': const KelolaPinjamanPage(),
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 255, 255, 255)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'Dashboard Admin',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 10, 10, 10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Pilih menu untuk mengelola data:',
                style: TextStyle(fontSize: 16, color: Color.fromARGB(179, 7, 7, 7)),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => item['page']),
                        );
                      },
                      child: Card(
                        elevation: 6,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: item['color'],
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          height: 100,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.white.withOpacity(0.3),
                                child: Icon(
                                  item['icon'],
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
