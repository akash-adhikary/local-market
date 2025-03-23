import 'package:flutter/material.dart';
import '../services/supabase_database_service.dart';

class AddRawMaterialScreen extends StatefulWidget {
  @override
  _AddRawMaterialScreenState createState() => _AddRawMaterialScreenState();
}

class _AddRawMaterialScreenState extends State<AddRawMaterialScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _dimensionController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final SupabaseDatabaseService dbService = SupabaseDatabaseService();

  List<Map<String, dynamic>> vendors = [];
  String? selectedVendor;
  int? selectedVendorId;

  @override
  void initState() {
    super.initState();
    _fetchVendors();
  }

  Future<void> _fetchVendors() async {
    vendors = await dbService.getVendors();
    setState(() {});
  }

  Future<void> _saveRawMaterial(BuildContext context) async {
    if (selectedVendorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a vendor')));
      return;
    }

    await dbService.addRawMaterial({
      'name': _nameController.text.trim(),
      'type': _typeController.text.trim(),
      'dimension': int.tryParse(_dimensionController.text.trim()) ?? 0,
      'color': _colorController.text.trim(),
      'unit': _unitController.text.trim(),
      'brand': _brandController.text.trim(),
      'vendor_id': selectedVendorId,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Raw Material')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Material Name')),
            TextField(controller: _typeController, decoration: InputDecoration(labelText: 'Type')),
            TextField(controller: _dimensionController, decoration: InputDecoration(labelText: 'Dimension'), keyboardType: TextInputType.number),
            TextField(controller: _colorController, decoration: InputDecoration(labelText: 'Color')),
            TextField(controller: _unitController, decoration: InputDecoration(labelText: 'Unit')),
            TextField(controller: _brandController, decoration: InputDecoration(labelText: 'Brand')),
            DropdownButtonFormField<String>(
              value: selectedVendor,
              hint: Text('Select Vendor'),
              items: vendors.map((vendor) {
                return DropdownMenuItem<String>(
                  value: vendor['name'],
                  child: Text(vendor['name']),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedVendor = value;
                  selectedVendorId = vendors.firstWhere((vendor) => vendor['name'] == value)['vendor_id'];
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => _saveRawMaterial(context), child: Text('Save Raw Material')),
          ],
        ),
      ),
    );
  }
}
