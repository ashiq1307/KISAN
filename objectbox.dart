import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'models/user.dart';
import 'models/msp.dart'; // Add this import
import 'objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<User> userBox;
  late final Box<MSP> mspBox; // Add this line

  static ObjectBox? _instance;

  ObjectBox._create(this.store) {
    userBox = Box<User>(store);
    mspBox = Box<MSP>(store); // Initialize MSP box
    
    // Initialize default MSP values if none exist
    _initializeDefaultMSP();
  }
  //async = to n fro movement of data between datbase and app
  static Future<ObjectBox> create() async {
    if (_instance != null) return _instance!;
    final dir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: dir.path);
    _instance = ObjectBox._create(store);
    return _instance!;
  }

  // Initialize default MSP values if none exist
  void _initializeDefaultMSP() {
    final crops = ['Rice Seed', 'Wheat', 'Mustard', 'Sugarcane'];
    final query = mspBox.query().build();
    final count = query.count();
    query.close();
    
    if (count == 0) {
      // No MSP values exist, create defaults
      for (var crop in crops) {
        final defaultPrice = 1000.0; // Default price
        final defaultUnit = 'per kg';
        
        final msp = MSP(
          cropName: crop,
          price: defaultPrice,
          unit: defaultUnit,
        );
        
        mspBox.put(msp);
      }
    }
  }

  // Get MSP for a specific crop
  MSP? getMSPForCrop(String cropName) {
    final query = mspBox.query(MSP_.cropName.equals(cropName)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  // Get all MSP values
  List<MSP> getAllMSP() {
    return mspBox.getAll();
  }

  // Update MSP for a crop
  void updateMSP(String cropName, double price) {
    final query = mspBox.query(MSP_.cropName.equals(cropName)).build();
    final msp = query.findFirst();
    query.close();
    
    if (msp != null) {
      msp.price = price;
      msp.lastUpdated = DateTime.now().millisecondsSinceEpoch;
      mspBox.put(msp);
    }
  }

  // In your ObjectBox class, ensure you have this method:
  Box<T> box<T>() => store.box<T>();
}