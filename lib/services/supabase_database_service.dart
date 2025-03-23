// import 'package:supabase_flutter/supabase_flutter.dart';

// class SupabaseDatabaseService {
//   final SupabaseClient supabase = Supabase.instance.client;

//   // 🔹 Add Customer
//   Future<void> addCustomer(Map<String, dynamic> data) async {
//     await supabase.from('customers').insert(data);
//   }

//   // 🔹 Get Customers
//   Future<List<Map<String, dynamic>>> getCustomers() async {
//     return await supabase.from('customers').select('*');
//   }

//   // 🔹 Delete Customer
//   Future<void> deleteCustomer(int id) async {
//     await supabase.from('customers').delete().eq('id', id);
//   }

//   // 🔹 Add Vendor (✅ Fix for missing method)
//   Future<void> addVendor(Map<String, dynamic> data) async {
//     await supabase.from('vendors').insert(data);
//   }

//   // 🔹 Get Vendors (✅ Fix for missing method)
//   Future<List<Map<String, dynamic>>> getVendors() async {
//     return await supabase.from('vendors').select('vendor_id, name');
//   }

//   // 🔹 Add Raw Material (✅ Fix for missing method)
//   Future<void> addRawMaterial(Map<String, dynamic> data) async {
//     await supabase.from('raw_materials').insert(data);
//   }

//   // 🔹 Get Raw Materials
//   Future<List<Map<String, dynamic>>> getRawMaterials() async {
//     return await supabase.from('raw_materials').select('*');
//   }
// }

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

  // 🔹 Update Customer
Future<void> updateCustomer(int id, Map<String, dynamic> data) async {
  await supabase.from('customers').update(data).eq('customer_id', id); // ✅ Correct column name
}

Future<void> deleteCustomer(int id) async {
  await supabase.from('customers').delete().eq('customer_id', id); // ✅ Ensure correct column name
}


  // 🔹 Add Vendor
  Future<void> addVendor(Map<String, dynamic> data) async {
    await supabase.from('vendors').insert(data);
  }

  // 🔹 Get Vendors
  Future<List<Map<String, dynamic>>> getVendors() async {
    return await supabase.from('vendors').select('*');
  }

  // 🔹 Update Vendor
  Future<void> updateVendor(int id, Map<String, dynamic> data) async {
    await supabase.from('vendors').update(data).eq('vendor_id', id);
  }

  // 🔹 Delete Vendor
  Future<void> deleteVendor(int id) async {
    await supabase.from('vendors').delete().eq('vendor_id', id);
  }

  // 🔹 Add Raw Material
  Future<void> addRawMaterial(Map<String, dynamic> data) async {
    await supabase.from('raw_materials').insert(data);
  }

  // 🔹 Get Raw Materials
  Future<List<Map<String, dynamic>>> getRawMaterials() async {
    return await supabase.from('raw_materials').select('*');
  }

  // 🔹 Update Raw Material
  Future<void> updateRawMaterial(int id, Map<String, dynamic> data) async {
    await supabase.from('raw_materials').update(data).eq('material_id', id);
  }

  // 🔹 Delete Raw Material
  Future<void> deleteRawMaterial(int id) async {
    await supabase.from('raw_materials').delete().eq('material_id', id);
  }
}
