import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'objectbox.dart';
import 'models/user.dart';
import 'package:email_validator/email_validator.dart';
import 'HomePageFam.dart';
import 'SignUp.dart'; // Import the SignUp page
import 'LoginPage.dart'; // Import the LoginPage page
import 'HomePageFam.dart'; // Import the HomePageFam page
import 'HomePageWholesaler.dart'; // Import the HomePageWholesaler page
import 'HomePageWholesaler.dart';
import 'objectbox.g.dart';
import 'AdminDashboard.dart'; // Add this import

class LoginPage extends StatefulWidget {
  final ObjectBox objectbox;
  LoginPage({required this.objectbox});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Check if this is an admin login
      if (_email == 'kisanadmin123@gmail.com' && _password == 'kisanadmin1') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Admin login successful!")));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard(objectbox: widget.objectbox)),
        );
        return;
      }
      
      // Regular user login logic
      final userBox = widget.objectbox.box<User>();
      final userQuery = userBox.query(User_.email.equals(_email)).build();
      final user = userQuery.findFirst();

      if (user != null && user.password == _password) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login successful!")));
        // In the _login method of LoginPage, update the navigation:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => user.userType == 'Farmer' 
            ? HomePageFam(objectbox: widget.objectbox) 
            : HomePageWholesaler(objectbox: widget.objectbox)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid email or password!")));
      }
      
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
        child: SingleChildScrollView(  // Add this ScrollView
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),  // Add some padding at the top
                  // Logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/logo.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  
                  // Welcome Text
                  Text(
                    'WELCOME',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20), // Dark green
                    ),
                  ),
                  Text(
                    'TO',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20), // Dark green
                    ),
                  ),
                  Text(
                    'KISAN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20), // Dark green
                    ),
                  ),
                  SizedBox(height: 40),
                  
                  // Login Text
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2E7D32), // Medium green
                    ),
                  ),
                  Text(
                    'Sign in to continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 30),
                  
                  // Email Field
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF8BBCB0), // Light green
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Email is required' : 
                                         EmailValidator.validate(value) ? null : 'Enter a valid email',
                      onSaved: (value) => _email = value!,
                    ),
                  ),
                  SizedBox(height: 15),
                  
                  // Password Field
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF8BBCB0), // Light green
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Please enter your password' : null,
                      onSaved: (value) => _password = value!,
                    ),
                  ),
                  SizedBox(height: 25),
                  
                  // Login Button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2E7D32), // Dark green
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Forgot Password
                  TextButton(
                    onPressed: () {
                      // Navigate to forgot password screen
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Color(0xFF2E7D32), // Dark green
                        fontSize: 16,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 15),
                  
                  // Sign Up Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to sign up screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp(objectbox: widget.objectbox)),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFF2E7D32),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
