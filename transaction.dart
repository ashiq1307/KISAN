import 'package:objectbox/objectbox.dart';
import 'user.dart';
import 'product.dart';

@Entity()
class Transaction {
  @Id()
  int id = 0;
  
  // Transaction date and time
  int timestamp; // Stored as milliseconds since epoch
  
  // Transaction type (buy/sell)
  String transactionType; // 'buy' or 'sell'
  
  // Quantity and amount
  double quantity;
  String unit;
  double totalAmount;
  
  // Status of the transaction
  String status; // 'pending', 'completed', 'cancelled'
  
  // Relations to User and Product
  // The user who initiated the transaction (could be farmer or wholesaler)
  @Index()
  final ToOne<User> user = ToOne<User>();
  
  // The product being traded
  @Index()
  final ToOne<Product> product = ToOne<Product>();
  
  Transaction({
    this.id = 0,
    required int timestamp,
    required this.transactionType,
    required this.quantity,
    required this.unit,
    required this.totalAmount,
    required this.status,
  }) : this.timestamp = timestamp;
  
  // Convenience getter for formatted date
  DateTime get date => DateTime.fromMillisecondsSinceEpoch(timestamp);
  
  // Convenience setter for date
  set date(DateTime dateTime) {
    timestamp = dateTime.millisecondsSinceEpoch;
  }
}