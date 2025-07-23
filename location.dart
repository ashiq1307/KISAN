import 'package:objectbox/objectbox.dart';
import 'user.dart';
import 'product.dart';

@Entity()
class Location {
  @Id()
  int id = 0;
  
  String name; // Name of the location
  String address; // Full address
  double latitude;
  double longitude;
  double area; // Area in acres or hectares
  String areaUnit; // 'acres' or 'hectares'
  
  // The crop/product grown at this location
  @Index()
  final ToOne<Product> product = ToOne<Product>();
  
  // The farmer who owns this location
  @Index()
  final ToOne<User> farmer = ToOne<User>();
  
  // Additional details
  String? soilType;
  String? irrigationSource;
  
  Location({
    this.id = 0,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.area,
    required this.areaUnit,
    this.soilType,
    this.irrigationSource,
  });
}