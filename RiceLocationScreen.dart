import 'package:flutter/material.dart';

class RiceLocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green.shade900),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Produced Details",
          style: TextStyle(color: Colors.green.shade900),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Product header
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              children: [
                // Product image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/rice.png',
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 15),
                
                // Product name
                Text(
                  "Rice Seeds",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                  ),
                ),
                SizedBox(height: 5),
                
                // MSP
                Text(
                  "MSP ~ 69Rs/kg",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
          ),
          
          // Location selection
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select a location",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // Location list
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  _buildLocationItem(
                    context,
                    "Palakkad",
                    "Sree Lakshya Agency",
                    "Kalarcode",
                    "68Rs/kg",
                    5.0,
                    66,
                  ),
                  Divider(),
                  _buildLocationItem(
                    context,
                    "Kuttanad",
                    "Kairali Agency",
                    "Thuruthy",
                    "65Rs/kg",
                    3.0,
                    32,
                  ),
                  Divider(),
                  _buildLocationItem(
                    context,
                    "Alappuzha",
                    "State Seed Farm",
                    "Komady",
                    "67Rs/kg",
                    4.0,
                    45,
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom navigation
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.home, "home", false),
                _buildNavItem(Icons.list_alt, "product list", true),
                _buildNavItem(Icons.landscape, "kisan ai", false),
                _buildNavItem(Icons.person, "profile", false),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLocationItem(
    BuildContext context,
    String location,
    String agency,
    String area,
    String price,
    double rating,
    int reviews,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          // Location icon
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.location_on,
              color: Colors.green,
              size: 30,
            ),
          ),
          SizedBox(width: 15),
          
          // Location details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  agency,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  area,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    _buildRatingStars(rating),
                    SizedBox(width: 5),
                    Text(
                      "($reviews)",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Price and buy button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: Colors.amber, size: 16);
        } else if (index < rating.ceil() && rating.floor() != rating.ceil()) {
          return Icon(Icons.star_half, color: Colors.amber, size: 16);
        } else {
          return Icon(Icons.star_border, color: Colors.amber, size: 16);
        }
      }),
    );
  }
  
  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.green.shade800 : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.green.shade800 : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}