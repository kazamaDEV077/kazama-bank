import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KelolaPinjamanPage extends StatefulWidget {
  const KelolaPinjamanPage({super.key});

  @override
  _KelolaPinjamanPageState createState() => _KelolaPinjamanPageState();
}

class _KelolaPinjamanPageState extends State<KelolaPinjamanPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> pinjamanList = [];

  // Function to fetch data from Firestore
  void _fetchPinjaman() async {
    final snapshot = await _firestore.collection('pinjaman').get();
    setState(() {
      pinjamanList = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'nama': doc['nama'],
          'jumlah': doc['jumlah'],
          'status': doc['status'],
          'tanggal': doc['tanggal'],
        };
      }).toList();
    });
  }

  // Function to save new pinjaman data to Firestore
  void _tambahPinjaman() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController namaController = TextEditingController();
        final TextEditingController jumlahController = TextEditingController();
        final TextEditingController tanggalController = TextEditingController();

        return AlertDialog(
          title: const Text('Tambah Pinjaman'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(labelText: 'Nama Peminjam'),
                ),
                TextField(
                  controller: jumlahController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Jumlah Pinjaman'),
                ),
                TextField(
                  controller: tanggalController,
                  decoration: const InputDecoration(labelText: 'Tanggal'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                final newPinjaman = {
                  'nama': namaController.text,
                  'jumlah': int.tryParse(jumlahController.text) ?? 0,
                  'status': 'Belum Lunas',
                  'tanggal': tanggalController.text,
                };

                await _firestore.collection('pinjaman').add(newPinjaman);

                _fetchPinjaman(); // Refresh the list
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // Function to edit pinjaman data in Firestore
  void _editPinjaman(Map<String, dynamic> pinjaman, int index) {
    final TextEditingController namaController =
        TextEditingController(text: pinjaman['nama']);
    final TextEditingController jumlahController =
        TextEditingController(text: pinjaman['jumlah'].toString());
    final TextEditingController tanggalController =
        TextEditingController(text: pinjaman['tanggal']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Pinjaman'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(labelText: 'Nama Peminjam'),
                ),
                TextField(
                  controller: jumlahController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Jumlah Pinjaman'),
                ),
                TextField(
                  controller: tanggalController,
                  decoration: const InputDecoration(labelText: 'Tanggal'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                final updatedPinjaman = {
                  'nama': namaController.text,
                  'jumlah': int.tryParse(jumlahController.text) ?? 0,
                  'status': pinjaman['status'],
                  'tanggal': tanggalController.text,
                };

                await _firestore
                    .collection('pinjaman')
                    .doc(pinjaman['id'])
                    .update(updatedPinjaman);

                _fetchPinjaman(); // Refresh the list
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // Function to delete pinjaman data from Firestore
  void _hapusPinjaman(int index) async {
    final pinjamanId = pinjamanList[index]['id'];
    await _firestore.collection('pinjaman').doc(pinjamanId).delete();
    _fetchPinjaman(); // Refresh the list
  }

  @override
  void initState() {
    super.initState();
    _fetchPinjaman(); // Fetch the initial data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Pinjaman'),
        backgroundColor: const Color.fromARGB(255, 118, 145, 150),
      ),
      body: ListView.builder(
        itemCount: pinjamanList.length,
        itemBuilder: (context, index) {
          final pinjaman = pinjamanList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                pinjaman['nama'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Jumlah Pinjaman: ${formatRupiah(pinjaman['jumlah'])}'),
                  Text('Status: ${pinjaman['status']}'),
                  Text('Tanggal Pinjaman: ${pinjaman['tanggal']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      _editPinjaman(pinjaman, index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _hapusPinjaman(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahPinjaman,
        backgroundColor: const Color.fromARGB(255, 132, 173, 180),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Function to format numbers as Rupiah currency
  String formatRupiah(int number) {
    return 'Rp${number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]}.',
    )}';
  }
}
