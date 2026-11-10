import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ChitFundApp());
}

class ChitFundApp extends StatelessWidget {
  const ChitFundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamari Chit Fund Family 2.0',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFf7f9fa),
      ),
      home: const MembersScreen(),
    );
  }
}

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final List<String> _members = [
    'Yamuna Verma',
    'Basanti Verma',
    'Pushpa Verma',
    'Dharmendra Verma',
    'Yashoda Mandavi',
    'Pravin Dhiver',
  ];

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  // Member par click karne par jama pop-up kholna
  void _openJamaDialog(String memberName) {
    List<String> selectedMonths = [];
    double amountPerMonth = 200;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text('$memberName - Jama Entry'),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Text('Mahine select karein:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ..._months.map((month) {
                      bool isSelected = selectedMonths.contains(month);
                      return CheckboxListTile(
                        title: Text('$month (₹$amountPerMonth)'),
                        value: isSelected,
                        activeColor: const Color(0xFF1b4332),
                        onChanged: (bool? value) {
                          setStateDialog(() {
                            if (value == true) {
                              selectedMonths.add(month);
                            } else {
                              selectedMonths.remove(month);
                            }
                          });
                        },
                      );
                    }),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Radd Karein'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1b4332), foregroundColor: Colors.white),
                  onPressed: () {
                    if (selectedMonths.isNotEmpty) {
                      Navigator.pop(context);
                      double totalAmount = selectedMonths.length * amountPerMonth;
                      String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
                      
                      String msg = "Dinank $currentDate\n\n$memberName ₹$totalAmount jama (${selectedMonths.join(', ')} ka kul hisaab)";
                      _sendToWhatsApp(msg);
                    }
                  },
                  child: const Text('Jama Karein & WhatsApp Bhejein'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Professional PDF Report Generate Karne Ka Function
  Future<void> _generateAndSharePdf(String memberName) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                alignment: pw.Alignment.center,
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: PdfColors.green900,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Text(
                  'HAMARI CHIT FUND FAMILY 2.0',
                  style: pw.TextStyle(color: PdfColors.white, fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Sadasya Report: $memberName', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Text('Jari karne ki tithi: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}', style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
              pw.SizedBox(height: 20),
              
              pw.Table.fromTextArray(
                headers: ['Mahina', 'Niyamit Rashiyan', 'Status'],
                data: _months.map((m) => [m, '₹200', 'Jama / Surakshit']).toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.green750),
                rowDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300))),
                cellAlignment: pw.Alignment.centerLeft,
              ),
              
              pw.SizedBox(height: 30),
              pw.Divider(),
              pw.Spacer(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Designed & Developed by: Pravin Chandra Dhiver', style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
                  pw.Text('Vishwas • Sahyog • Samridhi', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColors.green900)),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: '${memberName}_chit_fund_report.pdf');
  }

  void _sendToWhatsApp(String message) async {
    final encodedMessage = Uri.encodeComponent(message);
    final url = Uri.parse("https://wa.me/?text=$encodedMessage");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sadasya Suchi (Kul: ${_members.length})'),
        backgroundColor: const Color(0xFF1b4332),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _members.length,
              itemBuilder: (context, index) {
                final member = _members[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF1b4332),
                      foregroundColor: Colors.white,
                      child: Text('${index + 1}'),
                    ),
                    title: Text(member, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Tap to Jama or Export PDF'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                          onPressed: () => _generateAndSharePdf(member),
                          tooltip: 'PDF Report Share Karein',
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      ],
                    ),
                    onTap: () => _openJamaDialog(member),
                  ),
                );
              },
            ),
          ),
          // Developer Name Footer at bottom of Home Screen
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Designed & Developed by: Pravin Chandra Dhiver',
              style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
