import 'package:flutter/material.dart';
import '../services/supabase_database_service.dart';

class AddCustomerScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final SupabaseDatabaseService dbService = SupabaseDatabaseService();

  Future<void> _saveCustomer(BuildContext context) async {
    final name = _nameController.text.trim();
    final contact = _contactController.text.trim();

    if (name.isEmpty || contact.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    await dbService.addCustomer({'name': name, 'contact_info': contact});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Customer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Customer Name')),
            TextField(controller: _contactController, decoration: InputDecoration(labelText: 'Contact Info')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => _saveCustomer(context), child: Text('Save Customer')),
          ],
        ),
      ),
    );
  }
}
