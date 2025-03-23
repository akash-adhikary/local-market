import 'package:flutter/material.dart';
import '../services/supabase_database_service.dart';

class ViewCustomersScreen extends StatefulWidget {
  @override
  _ViewCustomersScreenState createState() => _ViewCustomersScreenState();
}

class _ViewCustomersScreenState extends State<ViewCustomersScreen> {
  final SupabaseDatabaseService dbService = SupabaseDatabaseService();
  List<Map<String, dynamic>> customers = [];

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    customers = await dbService.getCustomers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customers')),
      body: customers.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return ListTile(
                  title: Text(customer['name']),
                  subtitle: Text(customer['contact_info']),
                );
              },
            ),
    );
  }
}
