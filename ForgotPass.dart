import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'objectbox.dart';
import 'models/user.dart';
import 'package:email_validator/email_validator.dart';
import 'objectbox.g.dart'; // Add this import for User_ query

class ForgotPassScreen extends StatefulWidget {
  final ObjectBox objectbox;
  ForgotPassScreen({required this.objectbox});

  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Get the box for User objects
      final userBox = widget.objectbox.box<User>();
      
      // Create a query to find a user with the matching email
      final userQuery = userBox.query(User_.email.equals(_email)).build();
      final user = userQuery.findFirst();

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password reset link sent to $_email")));
        // Implement actual password reset logic here
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No account found with this email!")));
      }
      
      // Close the query when done
      userQuery.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(height: 20),
                  Text('Forgot Password',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green.shade700),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter your Email ID',
                      filled: true,
                      fillColor: Colors.green.shade100,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Email is required' : 
                                         EmailValidator.validate(value) ? null : 'Enter a valid email',
                    onSaved: (value) => _email = value!,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _resetPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                    ),
                    child: Text('Reset Password', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
