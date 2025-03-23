import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabaseService {
  final SupabaseClient supabase = Supabase.instance.client;

  // 🔹 Add Customer
  Future<void> addCustomer(Map<String, dynamic> data) async {
    await supabase.from('customers').insert(data);
  }

  // 🔹 Get Customers
  Future<List<Map<String, dynamic>>> getCustomers() async {
    return await supabase.from('customers').select('*');
  }

  // 🔹 Delete Customer
  Future<void> deleteCustomer(int id) async {
    await supabase.from('customers').delete().eq('id', id);
  }

  // 🔹 Add Vendor (✅ Fix for missing method)
  Future<void> addVendor(Map<String, dynamic> data) async {
    await supabase.from('vendors').insert(data);
  }

  // 🔹 Get Vendors (✅ Fix for missing method)
  Future<List<Map<String, dynamic>>> getVendors() async {
    return await supabase.from('vendors').select('vendor_id, name');
  }

  // 🔹 Add Raw Material (✅ Fix for missing method)
  Future<void> addRawMaterial(Map<String, dynamic> data) async {
    await supabase.from('raw_materials').insert(data);
  }

  // 🔹 Get Raw Materials
  Future<List<Map<String, dynamic>>> getRawMaterials() async {
    return await supabase.from('raw_materials').select('*');
  }
}
