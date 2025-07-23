import 'package:objectbox/objectbox.dart';

@Entity()
class Task {
  @Id()
  int id = 0;
  
  String title;
  String? description;
  bool completed = false;
  
  Task({
    required this.title,
    this.description,
    this.completed = false,
  });
}