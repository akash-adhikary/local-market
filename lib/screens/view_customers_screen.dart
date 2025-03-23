// import 'package:flutter/material.dart';
// import '../services/supabase_database_service.dart';

// class ViewCustomersScreen extends StatefulWidget {
//   @override
//   _ViewCustomersScreenState createState() => _ViewCustomersScreenState();
// }

// class _ViewCustomersScreenState extends State<ViewCustomersScreen> {
//   final SupabaseDatabaseService dbService = SupabaseDatabaseService();
//   List<Map<String, dynamic>> customers = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchCustomers();
//   }

//   Future<void> _fetchCustomers() async {
//     customers = await dbService.getCustomers();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Customers')),
//       body: customers.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: customers.length,
//               itemBuilder: (context, index) {
//                 final customer = customers[index];
//                 return ListTile(
//                   title: Text(customer['name']),
//                   subtitle: Text(customer['contact_info']),
//                 );
//               },
//             ),
//     );
//   }
// }
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

  // 🔹 Fetch Customers from Supabase
  Future<void> _fetchCustomers() async {
    customers = await dbService.getCustomers();
    setState(() {}); // ✅ Refresh UI
  }

  // 🔹 Edit Customer
  Future<void> _editCustomer(Map<String, dynamic> customer) async {
    TextEditingController nameController = TextEditingController(text: customer['name']);
    TextEditingController contactController = TextEditingController(text: customer['contact_info']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Customer"),
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
              await dbService.updateCustomer(customer['customer_id'], {
                'name': nameController.text.trim(),
                'contact_info': contactController.text.trim(),
              });
              Navigator.pop(context);
              _fetchCustomers(); // ✅ Refresh UI immediately
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  // 🔹 Delete Customer
  Future<void> _deleteCustomer(int id) async {
    await dbService.deleteCustomer(id);
    _fetchCustomers(); // ✅ Refresh list after deleting
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () => _editCustomer(customer)), // ✅ Edit Button
                      IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteCustomer(customer['customer_id'])), // ✅ Delete Button
                    ],
                  ),
                );
              },
            ),
    );
  }
}
