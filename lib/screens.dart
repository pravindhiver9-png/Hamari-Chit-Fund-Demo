import 'package:flutter/material.dart';

// 1. Member List Screen
class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final List> _members = [
    {'name': 'PRAVINCHANDRA', 'mobile': '9876543210', 'date': '01-01-2025'},
    {'name': 'Rajesh Kumar', 'mobile': '9123456789', 'date': '15-01-2025'},
  ];

  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();

  void _addMember() {
    if (_nameController.text.isNotEmpty && _mobileController.text.isNotEmpty) {
      setState(() {
        _members.add({
          'name': _nameController.text,
          'mobile': _mobileController.text,
          'date': DateTime.now().toString().substring(0, 10),
        });
      });
      _nameController.clear();
      _mobileController.clear();
      Navigator.pop(context);
    }
  }

  void _showAddMemberDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Naya Sadasya Jodein (Add Member)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Naam (Name)')),
            TextField(controller: _mobileController, decoration: const InputDecoration(labelText: 'Mobile Number'), keyboardType: TextInputType.phone),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: _addMember, child: const Text('Save')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sadasya Suchi (Member List)')),
      body: ListView.builder(
        itemCount: _members.length,
        itemBuilder: (context, index) {
          final m = _members[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
              ),
              title: Text(m['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Mobile: ${m['mobile']} | Date: ${m['date']}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMemberDialog,
        backgroundColor: const Color(0xFF1b4332),
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}
