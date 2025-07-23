import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id = 0;
  
  String name;
  String email;
  String password;
  String userType;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.userType,
  });
}