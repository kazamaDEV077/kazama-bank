import 'package:flutter/material.dart';

class DataPinjamanPage extends StatelessWidget {
  const DataPinjamanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar pinjaman yang ada
    List<Map<String, String>> pinjamanData = [
      {'title': 'Pinjaman 1', 'amount': 'Rp 10.000.000'},
      {'title': 'Pinjaman 2', 'amount': 'Rp 5.000.000'},
      {'title': 'Pinjaman 3', 'amount': 'Rp 7.500.000'},
      {'title': 'Pinjaman 4', 'amount': 'Rp 20.000.000'},
    ];

    // Jumlah data pinjaman
    int jumlahPinjaman = pinjamanData.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pinjaman'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Menampilkan jumlah data pinjaman
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Jumlah Data Pinjaman: $jumlahPinjaman',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          // Menampilkan daftar pinjaman
          ...pinjamanData.map((data) {
            return _buildDataTile(data['title']!, 'Jumlah: ${data['amount']!}', Icons.monetization_on);
          }),
        ],
      ),
    );
  }

  Widget _buildDataTile(String title, String subtitle, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
