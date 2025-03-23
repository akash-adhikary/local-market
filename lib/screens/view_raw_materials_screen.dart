// import 'package:flutter/material.dart';
// import '../services/supabase_database_service.dart';

// class ViewRawMaterialsScreen extends StatefulWidget {
//   @override
//   _ViewRawMaterialsScreenState createState() => _ViewRawMaterialsScreenState();
// }

// class _ViewRawMaterialsScreenState extends State<ViewRawMaterialsScreen> {
//   final SupabaseDatabaseService dbService = SupabaseDatabaseService();
//   List<Map<String, dynamic>> rawMaterials = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchRawMaterials();
//   }

//   Future<void> _fetchRawMaterials() async {
//     rawMaterials = await dbService.getRawMaterials();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Raw Materials')),
//       body: rawMaterials.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: rawMaterials.length,
//               itemBuilder: (context, index) {
//                 final material = rawMaterials[index];
//                 return ListTile(
//                   title: Text(material['name']),
//                   subtitle: Text("Type: ${material['type']} | Unit: ${material['unit']}"),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../services/supabase_database_service.dart';

class ViewRawMaterialsScreen extends StatefulWidget {
  @override
  _ViewRawMaterialsScreenState createState() => _ViewRawMaterialsScreenState();
}

class _ViewRawMaterialsScreenState extends State<ViewRawMaterialsScreen> {
  final SupabaseDatabaseService dbService = SupabaseDatabaseService();
  List<Map<String, dynamic>> rawMaterials = [];

  @override
  void initState() {
    super.initState();
    _fetchRawMaterials();
  }

  Future<void> _fetchRawMaterials() async {
    rawMaterials = await dbService.getRawMaterials();
    setState(() {});
  }

  Future<void> _editRawMaterial(Map<String, dynamic> material) async {
    TextEditingController nameController = TextEditingController(text: material['name']);
    TextEditingController typeController = TextEditingController(text: material['type']);
    TextEditingController colorController = TextEditingController(text: material['color']);
    TextEditingController unitController = TextEditingController(text: material['unit']);
    TextEditingController brandController = TextEditingController(text: material['brand']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Raw Material"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: typeController, decoration: InputDecoration(labelText: 'Type')),
            TextField(controller: colorController, decoration: InputDecoration(labelText: 'Color')),
            TextField(controller: unitController, decoration: InputDecoration(labelText: 'Unit')),
            TextField(controller: brandController, decoration: InputDecoration(labelText: 'Brand')),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await dbService.updateRawMaterial(material['material_id'], {
                'name': nameController.text.trim(),
                'type': typeController.text.trim(),
                'color': colorController.text.trim(),
                'unit': unitController.text.trim(),
                'brand': brandController.text.trim(),
              });
              _fetchRawMaterials();
              Navigator.pop(context);
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteRawMaterial(int id) async {
    await dbService.deleteRawMaterial(id);
    _fetchRawMaterials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Raw Materials')),
      body: rawMaterials.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: rawMaterials.length,
              itemBuilder: (context, index) {
                final material = rawMaterials[index];
                return ListTile(
                  title: Text(material['name']),
                  subtitle: Text("Type: ${material['type']} | Unit: ${material['unit']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () => _editRawMaterial(material)), // Edit
                      IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteRawMaterial(material['material_id'])), // Delete
                    ],
                  ),
                );
              },
            ),
    );
  }
}

