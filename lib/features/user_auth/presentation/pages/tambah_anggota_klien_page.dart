import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manajemen Anggota',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Pages for BottomNavigationBar
  static final List<Widget> _pages = [
    TambahAnggotaKlienPage(),
     MemberListPage(),
     MemberDetailPage(),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Tambah Anggota',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Daftar Anggota',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Detail Anggota',
          ),
        ],
      ),
    );
  }
}

class TambahAnggotaKlienPage extends StatelessWidget {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _asalController = TextEditingController();
  final TextEditingController _prodiController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TambahAnggotaKlienPage({super.key});

  Future<void> _addAnggota(BuildContext context) async {
    String nama = _namaController.text.trim();
    String asal = _asalController.text.trim();
    String prodi = _prodiController.text.trim();
    String semester = _semesterController.text.trim();
    String nim = _nimController.text.trim();

    if (nama.isNotEmpty &&
        asal.isNotEmpty &&
        prodi.isNotEmpty &&
        semester.isNotEmpty &&
        nim.isNotEmpty) {
      try {
        await _firestore.collection('anggota').add({
          'nama': nama,
          'asal': asal,
          'prodi': prodi,
          'semester': semester,
          'nim': nim,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Anggota berhasil ditambahkan!')),
        );
        _namaController.clear();
        _asalController.clear();
        _prodiController.clear();
        _semesterController.clear();
        _nimController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field wajib diisi!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Anggota'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(_namaController, 'Nama Lengkap'),
              const SizedBox(height: 12),
              _buildTextField(_asalController, 'Asal'),
              const SizedBox(height: 12),
              _buildTextField(_prodiController, 'Program Studi'),
              const SizedBox(height: 12),
              _buildTextField(_semesterController, 'Semester'),
              const SizedBox(height: 12),
              _buildTextField(_nimController, 'NIM'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _addAnggota(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Tambah Anggota',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class MemberListPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Color> cardColors = [
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
  ];

   MemberListPage({super.key});

  Widget _buildMemberCard(
      BuildContext context, Map<String, dynamic> anggota, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColors[index % cardColors.length],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: Text(
              anggota['nama']?[0]?.toUpperCase() ?? '?',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anggota['nama'] ?? 'Nama Tidak Diketahui',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Prodi: ${anggota['prodi'] ?? 'Tidak Diketahui'}',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  'Semester: ${anggota['semester'] ?? 'Tidak Diketahui'}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Text(
            '#${index + 1}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Anggota'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('anggota').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Belum ada anggota terdaftar.'),
            );
          }

          final anggotaList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: anggotaList.length,
            itemBuilder: (context, index) {
              final anggota =
                  anggotaList[index].data() as Map<String, dynamic>;
              return _buildMemberCard(context, anggota, index);
            },
          );
        },
      ),
    );
  }
}

class MemberDetailPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   MemberDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Anggota'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('anggota').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Belum ada anggota terdaftar.'),
            );
          }

          final anggotaList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: anggotaList.length,
            itemBuilder: (context, index) {
              final anggota =
                  anggotaList[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(anggota['nama'] ?? 'Nama Tidak Diketahui'),
                subtitle: Text(
                  'NIM: ${anggota['nim'] ?? 'Tidak Diketahui'}\n'
                  'Asal: ${anggota['asal'] ?? 'Tidak Diketahui'}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
