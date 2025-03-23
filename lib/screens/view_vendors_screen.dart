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
                );
              },
            ),
    );
  }
}
