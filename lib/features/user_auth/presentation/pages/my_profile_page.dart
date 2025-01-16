import 'package:flutter/material.dart';
import 'package:mobile_3_uas_kelompok_10/features/user_auth/presentation/pages/login_page.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Saya"),
        backgroundColor: const Color.fromARGB(255, 28, 49, 238),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 28, 49, 238),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile.jpeg'),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "SANJI OZWA",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profil'),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Keluar'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 235, 235, 240),
                  Color.fromARGB(255, 244, 244, 247),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  _showProfileDetails(context);
                },
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/profile.jpeg'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'SANJI OZWA',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 22, 13, 160),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'sanji.ozwa@example.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      const TabBar(
                        indicatorColor: Color.fromARGB(255, 24, 64, 243),
                        labelColor: Color.fromARGB(255, 24, 64, 243),
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(icon: Icon(Icons.group), text: "Anggota"),
                          Tab(icon: Icon(Icons.attach_money), text: "Pinjaman"),
                          Tab(icon: Icon(Icons.payment), text: "Angsuran"),
                          Tab(icon: Icon(Icons.folder), text: "Data"),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildAnggotaHistory(context),
                            _buildPinjamanHistory(context),
                            _buildAngsuranHistory(context),
                            _buildDataHistory(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showProfileDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text("Detail Profil"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile.jpeg'),
              ),
              SizedBox(height: 10),
              Text(
                'SANJI OZWA',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text('Email: sanji.ozwa@example.com'),
              Text('No. Telepon: +62 812 3456 7890'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnggotaHistory(BuildContext context) {
    return _buildListView([
      _buildHistoryItem(context,
          title: 'Registrasi Anggota', date: '01 Januari 2023'),
      _buildHistoryItem(context,
          title: 'Aktivasi Akun', date: '15 Februari 2023'),
      _buildHistoryItem(context,
          title: 'Verifikasi Identitas', date: '25 Maret 2023'),
    ]);
  }

  Widget _buildPinjamanHistory(BuildContext context) {
    return _buildListView([
      _buildHistoryItem(context,
          title: 'Pinjaman #12345',
          date: '01 April 2023',
          amount: 'Rp 5,000,000'),
      _buildHistoryItem(context,
          title: 'Pinjaman #12346',
          date: '15 Juli 2023',
          amount: 'Rp 10,000,000'),
      _buildHistoryItem(context,
          title: 'Pinjaman #12347',
          date: '20 Oktober 2023',
          amount: 'Rp 3,500,000'),
    ]);
  }

  Widget _buildAngsuranHistory(BuildContext context) {
    return _buildListView([
      _buildHistoryItem(context,
          title: 'Angsuran Pinjaman #12345',
          date: '01 Mei 2023',
          amount: 'Rp 1,000,000'),
      _buildHistoryItem(context,
          title: 'Angsuran Pinjaman #12346',
          date: '15 Agustus 2023',
          amount: 'Rp 2,000,000'),
      _buildHistoryItem(context,
          title: 'Angsuran Pinjaman #12347',
          date: '20 November 2023',
          amount: 'Rp 500,000'),
    ]);
  }

  Widget _buildDataHistory(BuildContext context) {
    return _buildListView([
      _buildHistoryItem(context,
          title: 'Data Diri Diperbarui', date: '01 Januari 2023'),
      _buildHistoryItem(context,
          title: 'Alamat Diperbarui', date: '15 Maret 2023'),
      _buildHistoryItem(context,
          title: 'Nomor Telepon Diperbarui', date: '20 Mei 2023'),
    ]);
  }

  Widget _buildListView(List<Widget> children) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: children,
    );
  }

  Widget _buildHistoryItem(BuildContext context,
      {required String title, required String date, String? amount}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        leading: const Icon(Icons.history, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Tanggal: $date'),
        trailing: amount != null
            ? Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              )
            : null,
      ),
    );
  }
}
