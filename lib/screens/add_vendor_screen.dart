import 'package:flutter/material.dart';
import '../services/supabase_database_service.dart';

class AddVendorScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final SupabaseDatabaseService dbService = SupabaseDatabaseService();

  Future<void> _saveVendor(BuildContext context) async {
    final name = _nameController.text.trim();
    final contact = _contactController.text.trim();
    final address = _addressController.text.trim();
    final city = _cityController.text.trim();
    final gst = _gstController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || contact.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill required fields')));
      return;
    }

    await dbService.addVendor({
      'name': name,
      'contact_info': contact,
      'address': address,
      'city': city,
      'gst': gst,
      'email_id': email,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Vendor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Vendor Name')),
            TextField(controller: _contactController, decoration: InputDecoration(labelText: 'Contact Info')),
            TextField(controller: _addressController, decoration: InputDecoration(labelText: 'Address')),
            TextField(controller: _cityController, decoration: InputDecoration(labelText: 'City')),
            TextField(controller: _gstController, decoration: InputDecoration(labelText: 'GST')),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => _saveVendor(context), child: Text('Save Vendor')),
          ],
        ),
      ),
    );
  }
}
