import 'package:objectbox/objectbox.dart';
import 'user.dart';
import 'product.dart';

@Entity()
class ProductInventory {
  @Id()
  int id = 0;
  
  // Quantity in stock
  double quantity;
  String unit;
  
  // Last updated timestamp
  int lastUpdated;
  
  // Relations
  @Index()
  final ToOne<Product> product = ToOne<Product>();
  
  @Index()
  final ToOne<User> owner = ToOne<User>(); // The wholesaler who owns this inventory
  
  ProductInventory({
    this.id = 0,
    required this.quantity,
    required this.unit,
    required int lastUpdated,
  }) : this.lastUpdated = lastUpdated;
  
  // Convenience getter for formatted date
  DateTime get updateDate => DateTime.fromMillisecondsSinceEpoch(lastUpdated);
  
  // Convenience setter for date
  set updateDate(DateTime dateTime) {
    lastUpdated = dateTime.millisecondsSinceEpoch;
  }
}