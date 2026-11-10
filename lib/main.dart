import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ChitFundApp());
}

class ChitFundApp extends StatefulWidget {
  const ChitFundApp({super.key});

  @override
  State<ChitFundApp> createState() => _ChitFundAppState();
}

class _ChitFundAppState extends State<ChitFundApp> {
  Locale _locale = const Locale('hi'); // Default language Hindi

  void _toggleLanguage() {
    setState(() {
      if (_locale.languageCode == 'hi') {
        _locale = const Locale('en');
      } else {
        _locale = const Locale('hi');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamari Chit Fund Family 2.0',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const (0xFFf7f9fa),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1b4332),
          foregroundColor: Colors.white,
        ),
      ),
      locale: _locale,
      home: HomeScreen(onToggleLanguage: _toggleLanguage, currentLang: _locale.languageCode),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onToggleLanguage;
  final String currentLang;

  const HomeScreen({super.key, required this.onToggleLanguage, required this.currentLang});

  @override
  Widget build(BuildContext context) {
    bool isHindi = currentLang == 'hi';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? 'हमारी चिट फंड फैमिली 2.0' : 'Hamari Chit Fund Family 2.0'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1b4332), Color(0xFF2d6a4f)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isHindi ? 'विश्वास • सहयोग • समृद्धि' : 'Vishwas • Sahyog • Samriddhi',
                    style: const TextStyle(color: Color(0xFFd8f3dc), fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isHindi ? 'डैशबोर्ड और लेज़र सिस्टम' : 'Dashboard & Ledger System',
                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Quick Modules Grid / Buttons
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildMenuCard(context, isHindi ? 'स सदस्य सूची' : 'Member List', Icons.people, Colors.teal),
                _buildMenuCard(context, isHindi ? 'मासिक जमा' : 'Monthly Jama', Icons.check_circle, Colors.green),
                _buildMenuCard(context, isHindi ? 'उधार प्रबंधन' : 'Loan (Udhar)', Icons.account_balance_wallet, Colors.orange),
                _buildMenuCard(context, isHindi ? 'खर्च और अतिरिक्त' : 'Expenses & Extra', Icons.receipt_long, Colors.brown),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title par click hua!')),
          );
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
