import 'package:flutter/material.dart';
import 'objectbox.dart';
import 'models/msp.dart';

class AdminDashboard extends StatefulWidget {
  final ObjectBox objectbox;
  
  AdminDashboard({required this.objectbox});
  
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for each crop
  final TextEditingController _riceController = TextEditingController();
  final TextEditingController _wheatController = TextEditingController();
  final TextEditingController _mustardController = TextEditingController();
  final TextEditingController _sugarcaneController = TextEditingController();
  
  List<MSP> mspList = [];
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadMSPData();
  }
  
  void _loadMSPData() async {
    setState(() {
      isLoading = true;
    });
    
    // Get all MSP values
    mspList = widget.objectbox.getAllMSP();
    
    // Set controller values
    for (var msp in mspList) {
      switch (msp.cropName) {
        case 'Rice Seed':
          _riceController.text = msp.price.toString();
          break;
        case 'Wheat':
          _wheatController.text = msp.price.toString();
          break;
        case 'Mustard':
          _mustardController.text = msp.price.toString();
          break;
        case 'Sugarcane':
          _sugarcaneController.text = msp.price.toString();
          break;
      }
    }
    
    setState(() {
      isLoading = false;
    });
  }
  
  void _updateMSP() {
    if (_formKey.currentState!.validate()) {
      // Update Rice MSP
      widget.objectbox.updateMSP('Rice Seed', double.parse(_riceController.text));
      
      // Update Wheat MSP
      widget.objectbox.updateMSP('Wheat', double.parse(_wheatController.text));
      
      // Update Mustard MSP
      widget.objectbox.updateMSP('Mustard', double.parse(_mustardController.text));
      
      // Update Sugarcane MSP
      widget.objectbox.updateMSP('Sugarcane', double.parse(_sugarcaneController.text));
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('MSP values updated successfully!')),
      );
      
      // Reload data to show updated values
      _loadMSPData();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard - MSP Management'),
        backgroundColor: Colors.green,
      ),
      body: isLoading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Set Minimum Support Price (MSP)',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Rice MSP
                  _buildMSPField(
                    'Rice Seed', 
                    'assets/rice.png', 
                    _riceController,
                  ),
                  SizedBox(height: 20),
                  
                  // Wheat MSP
                  _buildMSPField(
                    'Wheat', 
                    'assets/wheat.png', 
                    _wheatController,
                  ),
                  SizedBox(height: 20),
                  
                  // Mustard MSP
                  _buildMSPField(
                    'Mustard', 
                    'assets/mustard.png', 
                    _mustardController,
                  ),
                  SizedBox(height: 20),
                  
                  // Sugarcane MSP
                  _buildMSPField(
                    'Sugarcane', 
                    'assets/sugarcane.png', 
                    _sugarcaneController,
                  ),
                  SizedBox(height: 30),
                  
                  // Update Button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _updateMSP,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Update MSP Values',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Logout Button
                  Container(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
  
  Widget _buildMSPField(String cropName, String imagePath, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 60,
            height: 60,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cropName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'MSP (₹ per kg)',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter MSP value';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    _riceController.dispose();
    _wheatController.dispose();
    _mustardController.dispose();
    _sugarcaneController.dispose();
    super.dispose();
  }
}