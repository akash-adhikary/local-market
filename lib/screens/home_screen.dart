// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'add_customer_screen.dart';
// import 'add_vendor_screen.dart';
// import 'add_raw_material_screen.dart';
// import 'view_customers_screen.dart';
// import 'view_vendors_screen.dart';
// import 'view_raw_materials_screen.dart';
// import 'login_screen.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final SupabaseClient supabase = Supabase.instance.client;
//   String selectedView = 'Customers'; // Default dropdown selection

//   // 🔹 Get selected view based on dropdown choice
//   Widget _getSelectedView() {
//     switch (selectedView) {
//       case 'Customers':
//         return ViewCustomersScreen();
//       case 'Vendors':
//         return ViewVendorsScreen();
//       case 'Raw Materials':
//         return ViewRawMaterialsScreen();
//       default:
//         return ViewCustomersScreen();
//     }
//   }

//   // 🔹 Logout function
//   Future<void> _logout(BuildContext context) async {
//     await supabase.auth.signOut();
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())); // ✅ Redirect to login
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Home"),
//           actions: [
//             IconButton(icon: Icon(Icons.logout), onPressed: () => _logout(context)), // ✅ Logout button
//           ],
//           bottom: TabBar(
//             tabs: [
//               Tab(text: "Manage Data"),
//               Tab(text: "View Data"),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             // 🔹 Tab 1: Manage Data (Buttons to Add Data)
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddCustomerScreen())),
//                     child: Text("Add Customer"),
//                   ),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddVendorScreen())),
//                     child: Text("Add Vendor"),
//                   ),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddRawMaterialScreen())),
//                     child: Text("Add Raw Material"),
//                   ),
//                 ],
//               ),
//             ),

//             // 🔹 Tab 2: View Data (Dropdown + Dynamic List View)
//             Column(
//               children: [
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: DropdownButton<String>(
//                     value: selectedView,
//                     isExpanded: true,
//                     items: ['Customers', 'Vendors', 'Raw Materials']
//                         .map((String value) => DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             ))
//                         .toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedView = newValue!;
//                       });
//                     },
//                   ),
//                 ),
//                 Expanded(child: _getSelectedView()), // ✅ Show selected list dynamically
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'add_customer_screen.dart';
import 'add_vendor_screen.dart';
import 'add_raw_material_screen.dart';
import 'view_customers_screen.dart';
import 'view_vendors_screen.dart';
import 'view_raw_materials_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  String selectedView = 'Customers'; // Default dropdown selection

  // 🔹 Get selected view based on dropdown choice
  Widget _getSelectedView() {
    switch (selectedView) {
      case 'Customers':
        return ViewCustomersScreen();
      case 'Vendors':
        return ViewVendorsScreen();
      case 'Raw Materials':
        return ViewRawMaterialsScreen();
      default:
        return ViewCustomersScreen();
    }
  }

  // 🔹 Logout function
  Future<void> _logout(BuildContext context) async {
    await supabase.auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())); // ✅ Redirect to login
  }

  // 🔹 Refresh UI after adding data
  void _refreshData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(icon: Icon(Icons.logout), onPressed: () => _logout(context)), // ✅ Logout button
          ],
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddCustomerScreen()),
                      ).then((_) => _refreshData()); // ✅ Refresh after adding
                    },
                    child: Text("Add Customer"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddVendorScreen()),
                      ).then((_) => _refreshData()); // ✅ Refresh after adding
                    },
                    child: Text("Add Vendor"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddRawMaterialScreen()),
                      ).then((_) => _refreshData()); // ✅ Refresh after adding
                    },
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
                Expanded(child: _getSelectedView()), // ✅ Show selected list dynamically
              ],
            ),
          ],
        ),
      ),
    );
  }
}
