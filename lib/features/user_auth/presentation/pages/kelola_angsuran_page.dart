import 'package:flutter/material.dart';
import 'tambah_angsuran_page.dart'; // Import the new page

class KelolaAngsuranPage extends StatefulWidget {
  const KelolaAngsuranPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _KelolaAngsuranPageState createState() => _KelolaAngsuranPageState();
}

class _KelolaAngsuranPageState extends State<KelolaAngsuranPage> {
  List<Map<String, dynamic>> angsuranList = [
    // Pre-existing data for demonstration
    {
      'id': '1',
      'nama': 'geral',
      'jumlahAngsuran': 1000000,
      'tanggalJatuhTempo': '2024-12-25',
      'status': 'Lunas',
    },
    {
      'id': '2',
      'nama': 'azmi',
      'jumlahAngsuran': 1500000,
      'tanggalJatuhTempo': '2024-12-30',
      'status': 'Belum Lunas',
    },
  ];

  String formatRupiah(int number) {
    return 'Rp${number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        )}';
  }

  void _addAngsuran(Map<String, dynamic> newAngsuran) {
    setState(() {
      angsuranList.add(newAngsuran);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Angsuran'),
        backgroundColor: const Color.fromARGB(255, 151, 167, 173),
      ),
      body: ListView.builder(
        itemCount: angsuranList.length,
        itemBuilder: (context, index) {
          final angsuran = angsuranList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                angsuran['nama'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                      'Jumlah Angsuran: ${formatRupiah(angsuran['jumlahAngsuran'])}'),
                  Text('Tanggal Jatuh Tempo: ${angsuran['tanggalJatuhTempo']}'),
                  Text('Status: ${angsuran['status']}'),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the 'TambahAngsuranPage' to add a new installment
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahAngsuranPage(onSave: _addAngsuran),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 132, 173, 180),
        child: const Icon(Icons.add),
      ),
    );
  }
}
