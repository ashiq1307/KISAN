import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'objectbox.dart';
import 'LoginPage.dart';
import 'package:objectbox/objectbox.dart';
import 'AdminDashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final objectbox = await ObjectBox.create();
  
  if (kDebugMode) {
    try {
      final admin = Admin(objectbox.store); // Start the ObjectBox Admin UI
      print('ObjectBox Admin started: $admin');
    } catch (e) {
      print('Could not start ObjectBox Admin: $e');
    }
  }
  
  runApp(MyApp(objectbox: objectbox));
}

class MyApp extends StatelessWidget {
  final ObjectBox objectbox;
  
  const MyApp({Key? key, required this.objectbox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kisan App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(objectbox: objectbox),
      routes: {
        '/login': (context) => LoginPage(objectbox: objectbox),
        '/admin': (context) => AdminDashboard(objectbox: objectbox),
        // Add other routes as needed
      },
    );
  }
}
