// import 'package:flutter/material.dart';
// import '../services/supabase_database_service.dart';

// class ViewVendorsScreen extends StatefulWidget {
//   @override
//   _ViewVendorsScreenState createState() => _ViewVendorsScreenState();
// }

// class _ViewVendorsScreenState extends State<ViewVendorsScreen> {
//   final SupabaseDatabaseService dbService = SupabaseDatabaseService();
//   List<Map<String, dynamic>> vendors = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchVendors();
//   }

//   Future<void> _fetchVendors() async {
//     vendors = await dbService.getVendors();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Vendors')),
//       body: vendors.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: vendors.length,
//               itemBuilder: (context, index) {
//                 final vendor = vendors[index];
//                 return ListTile(
//                   title: Text(vendor['name']),
//                   subtitle: Text(vendor['contact_info']),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../services/supabase_database_service.dart';

class ViewVendorsScreen extends StatefulWidget {
  @override
  _ViewVendorsScreenState createState() => _ViewVendorsScreenState();
}

class _ViewVendorsScreenState extends State<ViewVendorsScreen> {
  final SupabaseDatabaseService dbService = SupabaseDatabaseService();
  List<Map<String, dynamic>> vendors = [];

  @override
  void initState() {
    super.initState();
    _fetchVendors();
  }

  Future<void> _fetchVendors() async {
    vendors = await dbService.getVendors();
    setState(() {});
  }

  Future<void> _editVendor(Map<String, dynamic> vendor) async {
    TextEditingController nameController = TextEditingController(text: vendor['name']);
    TextEditingController contactController = TextEditingController(text: vendor['contact_info']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Vendor"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: contactController, decoration: InputDecoration(labelText: 'Contact Info')),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await dbService.updateVendor(vendor['vendor_id'], {
                'name': nameController.text.trim(),
                'contact_info': contactController.text.trim(),
              });
              _fetchVendors();
              Navigator.pop(context);
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteVendor(int id) async {
    await dbService.deleteVendor(id);
    _fetchVendors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vendors')),
      body: vendors.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vendors.length,
              itemBuilder: (context, index) {
                final vendor = vendors[index];
                return ListTile(
                  title: Text(vendor['name']),
                  subtitle: Text(vendor['contact_info']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () => _editVendor(vendor)), // Edit
                      IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteVendor(vendor['vendor_id'])), // Delete
                    ],
                  ),
                );
              },
            ),
    );
  }
}
