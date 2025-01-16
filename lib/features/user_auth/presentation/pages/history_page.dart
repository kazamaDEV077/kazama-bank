import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 38, 51, 236)),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color.fromARGB(255, 247, 247, 247),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan informasi akun atau saldo
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 33, 48, 248),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Color.fromARGB(255, 205, 207, 212),
                    child: Icon(Icons.person, size: 40.0, color: Colors.blueAccent),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saldo Tersedia',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      Text(
                        'Rp 30,390',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            // Filter dan Sortir
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                  label: const Text('Filter'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 29, 31, 161), backgroundColor: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.sort),
                  label: const Text('Urutkan'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 19, 21, 148), backgroundColor: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Daftar transaksi
            Expanded(
              child: ListView(
                children: [
                  _buildTransactionItem(
                      title: 'Pembayaran Tagihan',
                      date: '2025-01-03 12:34',
                      amount: '-Rp 150,000',
                      status: 'Berhasil',
                      statusColor: Colors.green),
                  const Divider(),
                  _buildTransactionItem(
                      title: 'Top-up Saldo',
                      date: '2025-01-02 10:20',
                      amount: '+Rp 500,000',
                      status: 'Berhasil',
                      statusColor: Colors.green),
                  const Divider(),
                  _buildTransactionItem(
                      title: 'Pembayaran Cicilan',
                      date: '2025-01-01 15:45',
                      amount: '-Rp 300,000',
                      status: 'Gagal',
                      statusColor: Colors.red),
                  const Divider(),
                  _buildTransactionItem(
                      title: 'Pembayaran Pinjaman',
                      date: '2024-12-30 09:12',
                      amount: '-Rp 200,000',
                      status: 'Diproses',
                      statusColor: Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
      {required String title,
      required String date,
      required String amount,
      required String status,
      required Color statusColor}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: statusColor.withOpacity(0.2),
        child: Icon(
          status == 'Berhasil'
              ? Icons.check_circle
              : status == 'Diproses'
                  ? Icons.hourglass_empty
                  : Icons.cancel,
          color: statusColor,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date, style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
          Text(
            status,
            style: TextStyle(fontSize: 12.0, color: statusColor),
          ),
        ],
      ),
      trailing: Text(
        amount,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
    );
  }
}
