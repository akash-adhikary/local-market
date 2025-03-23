import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<bool> login(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(email: email, password: password);
      return response.session != null;
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
