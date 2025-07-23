import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'objectbox.dart';
import 'models/user.dart';
import 'objectbox.g.dart'; // Add this import to get User_
import 'package:email_validator/email_validator.dart';
import 'LoginPage.dart';

class SignUp extends StatefulWidget {
  final ObjectBox objectbox;
  SignUp({required this.objectbox});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _userType = 'Farmer'; // Default user type

  void _register() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Get the box for User objects
      final userBox = widget.objectbox.box<User>();
      
      // Check if a user with this email already exists
      final userQuery = userBox.query(User_.email.equals(_email)).build();
      final existingUser = userQuery.findFirst();
      
      if (existingUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("A user with this email already exists!"))
        );
      } else {
        // Create a new user
        final user = User(
          name: _name,
          email: _email,
          password: _password,
          userType: _userType,
        );
        
        // Save the user to the database
        userBox.put(user);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration successful!"))
        );
        
        // Navigate back to login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage(objectbox: widget.objectbox)),
        );
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  
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
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  
                  // Sign Up Text
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2E7D32), // Medium green
                    ),
                  ),
                  Text(
                    'Create a new account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 30),
                  
                  // Name Field
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF8BBCB0), // Light green
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Name is required' : null,
                      onSaved: (value) => _name = value!,
                    ),
                  ),
                  SizedBox(height: 15),
                  
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
                      validator: (value) => value == null || value.isEmpty ? 'Password is required' : null,
                      onSaved: (value) => _password = value!,
                      onChanged: (value) => _password = value, // Add this line to update password as user types
                    ),
                  ),
                  SizedBox(height: 15),
                  
                  // Confirm Password Field
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF8BBCB0), // Light green
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm your password',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _password) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onSaved: (value) => _confirmPassword = value!,
                    ),
                  ),
                  SizedBox(height: 15),
                  
                  // User Type Selection
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF8BBCB0), // Light green
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      value: _userType,
                      dropdownColor: Color(0xFF8BBCB0),
                      style: TextStyle(color: Colors.grey[800], fontSize: 16),
                      items: <String>['Farmer', 'Wholesaler'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _userType = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 25),
                  
                  // Register Button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2E7D32), // Dark green
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Already have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
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
