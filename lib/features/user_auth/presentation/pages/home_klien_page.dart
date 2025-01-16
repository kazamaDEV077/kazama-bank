import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'my_profile_page.dart';
import 'history_page.dart';
import 'dasbord_klieen_page.dart';
import 'payment_klien_page.dart';


class HomeClientPage extends StatefulWidget {
  const HomeClientPage({super.key});

  @override
  _HomeClientPageState createState() => _HomeClientPageState();
}

class _HomeClientPageState extends State<HomeClientPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double dynamicSize(double size) => size * (screenWidth / 375);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(
            color: Colors.white,
            fontSize: dynamicSize(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1E88E5),
        elevation: 0,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          WalletHomePage(),
          HistoryPage(),
          PaymentKlienPage(),
          DashboardClientPage(),
          MyProfilePage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color(0xFF1E88E5),
        height: dynamicSize(56),
        items: [
          Icon(Icons.home_outlined, size: dynamicSize(24), color: Colors.white),
          Icon(Icons.history, size: dynamicSize(24), color: Colors.white),
          Icon(Icons.payment, size: dynamicSize(24), color: Colors.white),
          Icon(Icons.dashboard, size: dynamicSize(24), color: Colors.white),
          Icon(Icons.perm_identity, size: dynamicSize(24), color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class WalletHomePage extends StatelessWidget {
  const WalletHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KAZAMA BANK BANK',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1E88E5),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardSection(),
            const SizedBox(height: 20),
            _buildActionButtons(context),
            const SizedBox(height: 20),
            _buildTransactionHistory(),
            const SizedBox(height: 20),
            _buildSavedTransfers(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E88E5), Color(0xFF64B5F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'KAZAMA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '4000 1234 5678 9010',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Valid Thru: 09/23',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Icon(Icons.credit_card, color: Colors.white, size: 28),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(Icons.send, 'Send'),
        _buildActionButton(Icons.arrow_downward, 'Receive'),
        _buildActionButton(Icons.book, 'Passbook'),
        _buildActionButton(Icons.more_horiz, 'More', onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashboardClientPage()),
          );
        }),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF64B5F6),
            radius: 28,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transactions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildTransactionItem('merlin', '+\$201.00', '02 April 2023'),
        _buildTransactionItem('geraldo', '+\$210.00', '01 April 2023'),
        _buildTransactionItem('azmi', '-\$50.00', '31 March 2023'),
         _buildTransactionItem('yaza', '-\$50.00', '31 March 2023'),
          _buildTransactionItem('riyan', '-\$50.00', '31 March 2023'),
      ],
    );
  }

  Widget _buildTransactionItem(String name, String amount, String date) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.person, color: Colors.grey[700]),
      ),
      title: Text(
        name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(date),
      trailing: Text(
        amount,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: amount.contains('-') ? Colors.red : Colors.green,
        ),
      ),
    );
  }

  Widget _buildSavedTransfers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Saved Transfers',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildSavedTransferItem('bayu ', '\$70.00', 'Auto-payment set'),
        _buildSavedTransferItem('gita', '\$15.00', 'Monthly payment'),
        _buildSavedTransferItem('yaza', '\$100.00', 'Scheduled for 5th Jan'),
      ],
    );
  }

  Widget _buildSavedTransferItem(String title, String amount, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Icon(Icons.payment, color: Colors.blue[700]),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      trailing: Text(
        amount,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: const HomeClientPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
    ),
  );
}
