import 'package:flutter/material.dart';
import 'MustardLocationScreen.dart';

class MustardSeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mustard Seeds"),
        backgroundColor: Colors.green.shade700,
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
                  image: AssetImage("assets/mustard.png"),
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
                        "Mustard Seeds",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "80Rs/kg",
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
                      Icon(Icons.star_half, color: Colors.amber),
                      SizedBox(width: 8),
                      Text("4.5 (124 reviews)"),
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
                    "Premium quality mustard seeds for cultivation. These seeds are known for their high oil content and excellent yield. Our mustard seeds are carefully selected to ensure optimal growth and disease resistance.",
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
                  _buildSpecificationItem("Variety", "Yellow Mustard (Brassica juncea)"),
                  _buildSpecificationItem("Origin", "Rajasthan, India"),
                  _buildSpecificationItem("Cultivation", "Organic"),
                  _buildSpecificationItem("Germination Rate", "90-95%"),
                  _buildSpecificationItem("Oil Content", "35-40%"),
                  _buildSpecificationItem("Packaging", "Available in 1kg, 5kg, 10kg bags"),
                  SizedBox(height: 24),
                  
                  // Growing Information
                  Text(
                    "Growing Information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildSpecificationItem("Soil Type", "Well-drained loamy soil"),
                  _buildSpecificationItem("Climate", "Cool, dry conditions (15-25°C)"),
                  _buildSpecificationItem("Sowing Method", "Broadcast or line sowing"),
                  _buildSpecificationItem("Sowing Depth", "1-2 cm"),
                  _buildSpecificationItem("Seed Rate", "5-6 kg/hectare"),
                  _buildSpecificationItem("Growing Season", "October to March (Rabi crop)"),
                  SizedBox(height: 24),
                  
                  // Pests & Diseases
                  Text(
                    "Common Pests & Diseases",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildBenefitItem("Aphids - Control with neem oil spray"),
                  _buildBenefitItem("White rust - Use resistant varieties"),
                  _buildBenefitItem("Alternaria blight - Proper spacing and fungicides"),
                  _buildBenefitItem("Downy mildew - Crop rotation and fungicides"),
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
                  _buildBenefitItem("High oil yield potential"),
                  _buildBenefitItem("Drought tolerant crop"),
                  _buildBenefitItem("Short growing season (110-130 days)"),
                  _buildBenefitItem("Low input requirement"),
                  _buildBenefitItem("Good market demand"),
                  SizedBox(height: 32),
                  
                  // View Sellers button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MustardLocationScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "View Sellers",
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