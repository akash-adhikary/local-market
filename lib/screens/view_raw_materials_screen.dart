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
                );
              },
            ),
    );
  }
}
