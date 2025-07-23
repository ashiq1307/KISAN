import 'package:objectbox/objectbox.dart';

@Entity()
class Product {
  @Id()
  int id = 0;
  
  String name; // Name of the product (e.g., Wheat, Rice, Mustard, SugarCane)
  String? description; // Description of the product
  double price; // Price per unit
  String unit; // Unit of measurement (e.g., kg, quintal)
  String? imageUrl; // URL or path to the product image
  
  // Index the name field for faster queries
  @Index()
  String searchName; // Lowercase name for case-insensitive search
  
  Product({
    this.id = 0,
    required this.name,
    this.description,
    required this.price,
    required this.unit,
    this.imageUrl,
  }) : searchName = name.toLowerCase();
}