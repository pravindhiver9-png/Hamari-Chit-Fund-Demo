import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard & Analytics')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Total Member Jama Card
          _buildMetricCard(
            'Kul Member Jama (Total Contribution)',
            '₹ 1,50,000',
            Icons.savings,
            Colors.green,
          ),
          const SizedBox(height: 12),
          // Total Udhar Issued Card
          _buildMetricCard(
            'Kul Udhar Issued (Total Loans)',
            '₹ 80,000',
            Icons.account_balance_wallet,
            Colors.orange,
          ),
          const SizedBox(height: 12),
          // Total Expected Interest (Sambhavit Byaj) Card
          _buildMetricCard(
            'Kul Sambhavit Byaj (Total Expected Interest)',
            '₹ 4,200',
            Icons.trending_up,
            Colors.indigo,
          ),
          const SizedBox(height: 12),
          // Member vs Non-Member Loan Breakdown Card
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Loan Category Breakdown',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Members Loan (2% Rate):'),
                      Text('₹ 50,000', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Non-Members Loan (5% Rate):'),
                      Text('₹ 30,000', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Samuh Shesh Fund (Remaining Cash Balance)
          _buildMetricCard(
            'Samuh Me Shesh Fund (Available Cash)',
            '₹ 74,200',
            Icons.money,
            Colors.teal,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String amount, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              radius: 24,
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(amount, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
