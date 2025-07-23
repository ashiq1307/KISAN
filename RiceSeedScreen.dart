import 'package:flutter/material.dart';
import 'RiceLocationScreen.dart';

class RiceSeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rice Seeds"),
        backgroundColor: const Color.fromRGBO(47, 121, 40, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/rice.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Product details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rice Seeds",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "69Rs/kg",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  
                  // Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 8),
                      Text("5.0 (156 reviews)"),
                    ],
                  ),
                  SizedBox(height: 24),
                  
                  // Description
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Premium quality rice seeds sourced from Kerala's finest paddy fields. These high-yield rice seeds are perfect for cultivation in various soil conditions. Our seeds undergo rigorous quality checks to ensure optimal germination rates and disease resistance.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24),
                  
                  // Specifications
                  Text(
                    "Specifications",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildSpecificationItem("Variety", "Jyothi (Red Kerala Rice)"),
                  _buildSpecificationItem("Origin", "Kerala, India"),
                  _buildSpecificationItem("Cultivation", "Organic"),
                  _buildSpecificationItem("Germination Rate", "95-98%"),
                  _buildSpecificationItem("Moisture Content", "< 12%"),
                  _buildSpecificationItem("Packaging", "Available in 1kg, 5kg, 10kg bags"),
                  SizedBox(height: 24),
                  
                  // Benefits
                  Text(
                    "Benefits",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildBenefitItem("High yield potential"),
                  _buildBenefitItem("Disease and pest resistant"),
                  _buildBenefitItem("Adaptable to various soil conditions"),
                  _buildBenefitItem("Supports sustainable farming"),
                  _buildBenefitItem("Excellent cooking quality and aroma"),
                  SizedBox(height: 32),
                  
                  // View Sellers button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to rice location screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RiceLocationScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "View Sellers",
                          selectionColor: const Color.fromARGB(255, 255, 255, 255),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSpecificationItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBenefitItem(String benefit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green.shade700, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              benefit,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}