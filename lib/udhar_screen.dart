import 'package:flutter/material.dart';

class UdharScreen extends StatefulWidget {
  const UdharScreen({super.key});

  @override
  State<UdharScreen> createState() => _UdharScreenState();
}

class _UdharScreenState extends State<UdharScreen> {
  // Sample active loan data with rules
  final List> _loans = [
    {
      'kramank': '1',
      'name': 'Rajesh Kumar',
      'mobile': '9123456789',
      'muldhan': 10000.0,
      'date': '2026-01-01',
      'rate': 2.0, // Member rate
      'status': 'Active',
    },
    {
      'kramank': '2',
      'name': 'Suresh Verma',
      'mobile': '9988776655',
      'muldhan': 5000.0,
      'date': '2026-02-01',
      'rate': 5.0, // Non-Member rate
      'status': 'Active',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Udhar (Loan) Management')),
      body: ListView.builder(
        itemCount: _loans.length,
        itemBuilder: (context, index) {
          final loan = _loans[index];
          // Calculate dynamic days elapsed from loan date to today
          DateTime loanDate = DateTime.parse(loan['date']);
          int daysElapsed = DateTime.now().difference(loanDate).inDays;
          if (daysElapsed < 0) daysElapsed = 0;

          // Auto-calculated expected interest formula (Principal * Rate% * Months or Days approx)
          double monthlyRate = loan['rate'];
          double expectedInterest = (loan['muldhan'] * monthlyRate * (daysElapsed / 30)) / 100;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kramank #${loan['kramank']} - ${loan['name']}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Chip(
                        label: Text('${loan['rate']}% Byaj', style: const TextStyle(color: Colors.white, fontSize: 12)),
                        backgroundColor: loan['rate'] == 2.0 ? Colors.green : Colors.orange,
                      ),
                    ],
                  ),
                  const Divider(),
                  Text('Mobile: ${loan['mobile']}'),
                  Text('Muldhan (Principal): ₹${loan['muldhan']}'),
                  Text('Loan Date: ${loan['date']} | Avdhi: $daysElapsed Din (Days)'),
                  const SizedBox(height: 5),
                  Text(
                    'Sambhavit Byaj (Expected Interest): ₹${expectedInterest.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: End,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          // Statement or Payment action
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${loan['name']} ka Statement khul raha hai...')),
                          );
                        },
                        icon: const Icon(Icons.receipt, size: 16),
                        label: const Text('Statement / Jama'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Naya Udhar Jodne ka form yahan khulega')),
          );
        },
        backgroundColor: const Color(0xFF1b4332),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
