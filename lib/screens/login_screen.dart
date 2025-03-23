// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'home_screen.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final SupabaseClient supabase = Supabase.instance.client;
//   final _formKey = GlobalKey<FormState>(); // ✅ Add Form Key

//   Future<void> _login() async {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter email and password')));
//       return;
//     }

//     try {
//       final response = await supabase.auth.signInWithPassword(email: email, password: password);

//       if (response.session != null) {
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form( // ✅ Wrap in Form
//           key: _formKey,
//           child: Column(
//             children: [
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 textInputAction: TextInputAction.next, // ✅ Moves to the next field when Enter is pressed
//               ),
//               TextField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 textInputAction: TextInputAction.done, // ✅ Triggers submission when Enter is pressed
//                 onSubmitted: (value) => _login(), // ✅ Calls _login() when Enter is pressed
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(onPressed: _login, child: Text('Login')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SupabaseClient supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter email and password')));
      return;
    }

    try {
      final response = await supabase.auth.signInWithPassword(email: email, password: password);

      if (response.session != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())); // ✅ Auto-login
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email'), textInputAction: TextInputAction.next),
              TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true, textInputAction: TextInputAction.done, onSubmitted: (value) => _login()),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: Text('Login')),
            ],
          ),
        ),
      ),
    );
  }
}

