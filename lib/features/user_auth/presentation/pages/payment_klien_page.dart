import 'package:flutter/material.dart';

class PaymentKlienPage extends StatefulWidget {
  const PaymentKlienPage({super.key});

  @override
  _PaymentKlienPageState createState() => _PaymentKlienPageState();
}

class _PaymentKlienPageState extends State<PaymentKlienPage> {
  bool isSubscribed = false;
  List<Map<String, dynamic>> transactions = [
    {'date': '2025-01-01', 'amount': 50000, 'status': 'Success'},
    {'date': '2025-01-02', 'amount': 100000, 'status': 'Pending'},
    {'date': '2025-01-03', 'amount': 75000, 'status': 'Failed'},
  ];

  void subscribe() {
    setState(() {
      isSubscribed = !isSubscribed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dashboard Pembayaran',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDashboardCard('Total Pembayaran', 'Rp 5,000,000', Icons.monetization_on),
                  _buildDashboardCard('Berlangganan', isSubscribed ? 'Aktif' : 'Tidak Aktif', Icons.subscriptions),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Riwayat Transaksi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(
                        transaction['status'] == 'Success'
                            ? Icons.check_circle
                            : transaction['status'] == 'Pending'
                                ? Icons.hourglass_empty
                                : Icons.cancel,
                        color: transaction['status'] == 'Success'
                            ? Colors.green
                            : transaction['status'] == 'Pending'
                                ? Colors.orange
                                : Colors.red,
                      ),
                      title: Text('Tanggal: ${transaction['date']}'),
                      subtitle: Text('Jumlah: Rp ${transaction['amount']}'),
                      trailing: Text(transaction['status']),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Paket Berlangganan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Paket Premium',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            isSubscribed ? 'Aktif' : 'Tidak Aktif',
                            style: TextStyle(
                              fontSize: 14,
                              color: isSubscribed ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('Harga: Rp 100.000/bulan'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: subscribe,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isSubscribed ? Colors.red : Colors.blue,
                        ),
                        child: Text(
                          isSubscribed ? 'Batalkan Berlangganan' : 'Berlangganan',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: Colors.blue),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PaymentKlienPage(),
  ));
}
