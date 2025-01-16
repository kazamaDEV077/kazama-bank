import 'package:flutter/material.dart';


class TambahAngsuranPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const TambahAngsuranPage({super.key, required this.onSave});

  @override
  _TambahAngsuranPageState createState() => _TambahAngsuranPageState();
}

class _TambahAngsuranPageState extends State<TambahAngsuranPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 90, 87, 87),
      appBar: AppBar(
        title: const Text('Tambah Angsuran'),
        backgroundColor: const Color.fromARGB(255, 45, 55, 72), // AppBar color
        elevation: 0, // No shadow under the app bar
      ),
      body: Stack(
        children: [
          // Background Decoration (Gradient)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 139, 168, 170), Color.fromARGB(255, 112, 186, 196)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          // Center the form content
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95), // Semi-transparent white background
                  borderRadius: BorderRadius.circular(30), // Rounded corners for the container
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tambah Angsuran',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: namaController,
                      label: 'Nama Peminjam',
                      icon: Icons.person,
                    ),
                    _buildTextField(
                      controller: jumlahController,
                      label: 'Jumlah Angsuran',
                      icon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                    ),
                    _buildTextField(
                      controller: tanggalController,
                      label: 'Tanggal Jatuh Tempo',
                      icon: Icons.calendar_today,
                    ),
                    _buildTextField(
                      controller: statusController,
                      label: 'Status',
                      icon: Icons.check_circle,
                    ),
                    const SizedBox(height: 32),
                    // Save Button with login-like appearance
                    GestureDetector(
                      onTap: _saveAngsuran,
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color.fromARGB(255, 201, 204, 206), Color.fromARGB(255, 172, 188, 201)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Simpan Angsuran',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 17, 16, 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom method to build text fields with icons and styling
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color.fromARGB(255, 23, 23, 24)),
          prefixIcon: Icon(icon, color: const Color.fromARGB(255, 236, 38, 3)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color.fromARGB(255, 231, 15, 15), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color.fromARGB(255, 112, 124, 145)),
          ),
        ),
      ),
    );
  }

  void _saveAngsuran() {
    final nama = namaController.text;
    final jumlah = int.tryParse(jumlahController.text) ?? 0;
    final tanggal = tanggalController.text;
    final status = statusController.text;

    if (nama.isNotEmpty && jumlah > 0 && tanggal.isNotEmpty && status.isNotEmpty) {
      final newAngsuran = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'nama': nama,
        'jumlahAngsuran': jumlah,
        'tanggalJatuhTempo': tanggal,
        'status': status,
      };

      widget.onSave(newAngsuran);

      Navigator.pop(context);
    } else {
      // Display a message if fields are not filled
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('All fields are required and the amount must be a valid number.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}


