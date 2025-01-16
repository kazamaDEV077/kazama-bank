import 'package:flutter/material.dart';

class DataAngsuranPage extends StatelessWidget {
  const DataAngsuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Angsuran'),
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDataTile('Angsuran 1', 'Jumlah: Rp 1.000.000', Icons.receipt),
          _buildDataTile('Angsuran 2', 'Jumlah: Rp 500.000', Icons.receipt),
          _buildDataTile('Angsuran 3', 'Jumlah: Rp 750.000', Icons.receipt),
          _buildDataTile('Angsuran 4', 'Jumlah: Rp 2.000.000', Icons.receipt),
        ],
      ),
    );
  }

  Widget _buildDataTile(String title, String subtitle, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
