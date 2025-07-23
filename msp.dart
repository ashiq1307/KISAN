import 'package:objectbox/objectbox.dart';

@Entity()
class MSP {
  @Id()
  int id = 0;
  
  String cropName;
  double price;
  String unit;
  int lastUpdated;
  
  MSP({
    this.id = 0,
    required this.cropName,
    required this.price,
    required this.unit,
    int? lastUpdated,
  }) : this.lastUpdated = lastUpdated ?? DateTime.now().millisecondsSinceEpoch;
  
  // Convenience getter for formatted date
  DateTime get updateDate => DateTime.fromMillisecondsSinceEpoch(lastUpdated);
  
  // Convenience setter for date
  set updateDate(DateTime dateTime) {
    lastUpdated = dateTime.millisecondsSinceEpoch;
  }
}