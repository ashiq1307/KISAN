// This is a mock implementation of ObjectBox for testing
class ObjectBox {
  static final ObjectBox _instance = ObjectBox._();
  
  // Private constructor
  ObjectBox._();
  
  // Singleton pattern
  static ObjectBox get instance => _instance;
  
  // Mock box method
  Box<T> box<T>() => Box<T>();
}

class Box<T> {
  int put(T object) {
    // Mock successful insertion
    return 1;
  }
}