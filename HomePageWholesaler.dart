import 'package:flutter/material.dart';
import 'objectbox.dart';
import 'models/msp.dart';

class HomePageWholesaler extends StatefulWidget {
  final ObjectBox objectbox;
  
  HomePageWholesaler({required this.objectbox});
  
  @override
  _HomePageWholesalerState createState() => _HomePageWholesalerState();
}

class _HomePageWholesalerState extends State<HomePageWholesaler> {
  Map<String, MSP?> mspValues = {};
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadMSPValues();
  }
  
  Future<void> _loadMSPValues() async {
    setState(() {
      isLoading = true;
    });
    
    // Fetch MSP values for all crops
    mspValues = {
      'Rice Seeds': widget.objectbox.getMSPForCrop('Rice Seed'),
      'Wheat Seeds': widget.objectbox.getMSPForCrop('Wheat'),
      'Mustard Seeds': widget.objectbox.getMSPForCrop('Mustard'),
      'Sugarcane': widget.objectbox.getMSPForCrop('Sugarcane'),
      'Chilly': widget.objectbox.getMSPForCrop('Chilly') ?? MSP(cropName: 'Chilly', price: 80, unit: 'per kg'),
    };
    
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F2F1),
      appBar: AppBar(
        backgroundColor: Color(0xFF2E7D32),
        elevation: 0,
        title: Text(
          "MARKET",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(Icons.person, color: Colors.white),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(Icons.shopping_bag, color: Colors.white),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: isLoading 
        ? Center(child: CircularProgressIndicator())
        : Column(
          children: [
            // Header section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              color: Color(0xFF2E7D32),
              width: double.infinity,
              child: Text(
                "CHOOSE A PRODUCT",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            // Product list
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10),
                children: [
                  _buildProductListItem("Rice Seeds", mspValues['Rice Seeds']?.price.toString() ?? "Loading...", "assets/rice.png"),
                  _buildProductListItem("Wheat Seeds", mspValues['Wheat Seeds']?.price.toString() ?? "Loading...", "assets/wheat.png"),
                  _buildProductListItem("Mustard Seeds", mspValues['Mustard Seeds']?.price.toString() ?? "Loading...", "assets/mustard.png"),
                  _buildProductListItem("Sugarcane", mspValues['Sugarcane']?.price.toString() ?? "Loading...", "assets/sugarcane.png"),
                  
                ],
              ),
            ),
            
            // Bottom Navigation Bar
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2E7D32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home,"home" ,true),
                  _buildNavItem(Icons.landscape,"AI", false),
                  _buildNavItem(Icons.notifications, "Notifications", false),
                ],
              ),
            ),
          ],
        ),
    );
  }
  
  Widget _buildProductListItem(String name, String price, String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          "₹$price/kg",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border, color: Colors.green),
            SizedBox(width: 15),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "BUY NOW",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the text color t
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2E7D32),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}