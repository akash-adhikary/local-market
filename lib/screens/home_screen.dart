import 'package:flutter/material.dart';
import 'add_customer_screen.dart';
import 'add_vendor_screen.dart';
import 'add_raw_material_screen.dart';
import 'view_customers_screen.dart';
import 'view_vendors_screen.dart';
import 'view_raw_materials_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedView = 'Customers'; // Default dropdown selection

  Widget _getSelectedView() {
    switch (selectedView) {
      case 'Customers':
        return ViewCustomersScreen();
      case 'Vendors':
        return ViewVendorsScreen();
      case 'Raw Materials':
        return ViewRawMaterialsScreen();
      default:
        return ViewCustomersScreen(); // Default fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Manage Data"),
              Tab(text: "View Data"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 🔹 Tab 1: Manage Data (Buttons to Add Data)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddCustomerScreen())),
                    child: Text("Add Customer"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddVendorScreen())),
                    child: Text("Add Vendor"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddRawMaterialScreen())),
                    child: Text("Add Raw Material"),
                  ),
                ],
              ),
            ),

            // 🔹 Tab 2: View Data (Dropdown + Dynamic List View)
            Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<String>(
                    value: selectedView,
                    isExpanded: true,
                    items: ['Customers', 'Vendors', 'Raw Materials']
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedView = newValue!;
                      });
                    },
                  ),
                ),
                Expanded(child: _getSelectedView()), // Show selected list
              ],
            ),
          ],
        ),
      ),
    );
  }
}
