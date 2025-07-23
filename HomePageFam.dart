import 'package:flutter/material.dart';
import 'screens/Rice/RiceSeedScreen.dart';
import 'screens/Wheat/WheatScreen.dart';
import 'screens/Mustard/MustardSeedScreen.dart';
import 'screens/SugarCane/SugarCaneScreen.dart';
import 'objectbox.dart';
import 'models/msp.dart';

class HomePageFam extends StatefulWidget {
  final ObjectBox objectbox;
  
  HomePageFam({required this.objectbox});
  
  @override
  _HomePageFamState createState() => _HomePageFamState();
}

class _HomePageFamState extends State<HomePageFam> {
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
      'Wheat grains': widget.objectbox.getMSPForCrop('Wheat'),
      'Mustard Seeds': widget.objectbox.getMSPForCrop('Mustard'),
      'Sugar Cane': widget.objectbox.getMSPForCrop('Sugarcane'),
    };
    
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading 
        ? Center(child: CircularProgressIndicator())
        : Column(
          children: [
            // Top section with greeting and farmer image
            Container(
              padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 30),
              decoration: BoxDecoration(
                color: Color(0xFFE0F7FA),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Menu dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.more_horiz, color: const Color.fromRGBO(46, 125, 50, 1)),
                      Icon(Icons.notifications, color: const Color.fromRGBO(46, 125, 50, 1)),
                    ],
                  ),
                  SizedBox(height: 10),
                  
                  // Greeting and illustration
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Greeting text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi, Farmer!",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade900,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Welcome to your dashboard",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Farmer illustration
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green.shade200, width: 2),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/logo.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            
            // Featured Products section
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Featured Products header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Featured Products",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Text(
                            "See All",
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    // Products grid
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.85,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        children: [
                          _buildProductCard(
                            context, 
                            "Rice Seeds", 
                            mspValues['Rice Seeds']?.price.toString() ?? "Loading...", 
                            "assets/rice.png",
                            mspValues['Rice Seeds']?.unit ?? "per kg"
                          ),
                          _buildProductCard(
                            context, 
                            "Wheat grains", 
                            mspValues['Wheat grains']?.price.toString() ?? "Loading...", 
                            "assets/wheat.png",
                            mspValues['Wheat grains']?.unit ?? "per kg"
                          ),
                          _buildProductCard(
                            context, 
                            "Mustard Seeds", 
                            mspValues['Mustard Seeds']?.price.toString() ?? "Loading...", 
                            "assets/mustard.png",
                            mspValues['Mustard Seeds']?.unit ?? "per kg"
                          ),
                          _buildProductCard(
                            context, 
                            "Sugar Cane", 
                            mspValues['Sugar Cane']?.price.toString() ?? "Loading...", 
                            "assets/sugarcane.png",
                            mspValues['Sugar Cane']?.unit ?? "per kg"
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Navigation Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home, "home", true),
                  _buildNavItem(Icons.list_alt, "product list", false),
                  _buildNavItem(Icons.landscape, "kisan ai", false),
                  _buildNavItem(Icons.person, "profile", false),
                ],
              ),
            ),
          ],
        ),
    );
  }
  
  Widget _buildProductCard(BuildContext context, String name, String price, String imagePath, String unit) {
    return InkWell(
      onTap: () {
        if (name == "Rice Seeds") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RiceSeedScreen()),
          );
        } else if (name == "Wheat grains") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WheatScreen()),
          );
        } else if (name == "Mustard Seeds") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MustardSeedScreen()),
          );
        } else if (name == "Sugar Cane") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SugarCaneScreen()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "MSP",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "₹$price $unit",
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.green.shade700,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () {
        // Handle navigation
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.green.shade800 : Colors.grey,
            size: 24,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.green.shade800 : Colors.grey,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}