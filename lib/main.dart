import 'package:flutter/material.dart';
import 'screens.dart';
import 'udhar_screen.dart';
import 'dashboard_screen.dart';

void main() {
  runApp(const ChitFundApp());
}

class ChitFundApp extends StatefulWidget {
  const ChitFundApp({super.key});

  @override
  State<ChitFundApp> createState() => _ChitFundAppState();
}

class _ChitFundAppState extends State<ChitFundApp> {
  Locale _locale = const Locale('hi', '');

  void _toggleLanguage() {
    setState(() {
      if (_locale.languageCode == 'hi') {
        _locale = const Locale('en', '');
      } else {
        _locale = const Locale('hi', '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamari Chit Fund Family 2.0',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFf7f9fa),
      ),
      home: HomeScreen(onToggleLanguage: _toggleLanguage, currentLocale: _locale),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onToggleLanguage, required this.currentLocale});
  
  final VoidCallback onToggleLanguage;
  final Locale currentLocale;

  @override
  Widget build(BuildContext context) {
    bool isHindi = currentLocale.languageCode == 'hi';

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? 'हमारी चिट फंड फैमिली 2.0' : 'Hamari Chit Fund Family 2.0'),
        backgroundColor: const Color(0xFF1b4332),
        foregroundColor: Colors.white,
        actions: [
          TextButton.icon(
            onPressed: onToggleLanguage,
            icon: const Icon(Icons.language, color: Colors.white),
            label: Text(
              isHindi ? 'English' : 'हिंदी',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1b4332),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isHindi ? 'विश्वास • सहयोग • समृद्धि' : 'Trust • Support • Prosperity',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 6),
                Text(
                  isHindi ? 'डैशबोर्ड और लेज़र सिस्टम' : 'Dashboard & Ledger System',
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildMenuCard(
                context,
                isHindi ? 'सदस्य सूची' : 'Member List',
                Icons.group,
                Colors.blue,
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MembersScreen()));
                },
              ),
              _buildMenuCard(
                context,
                isHindi ? 'मासिक जमा' : 'Monthly Jama',
                Icons.check_circle,
                Colors.green,
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
                },
              ),
              _buildMenuCard(
                context,
                isHindi ? 'उधार प्रबंधन' : 'Udhar Management',
                Icons.account_balance_wallet,
                Colors.orange,
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UdharScreen()));
                },
              ),
              _buildMenuCard(
                context,
                isHindi ? 'खर्च और अतिरिक्त' : 'Kharch & Atirikt',
                Icons.receipt_long,
                Colors.brown,
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
