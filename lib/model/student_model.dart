import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel extends HiveObject {
  @HiveField(0)
  String username;
  @HiveField(1)
  int age;

  StudentModel({required this.username, required this.age});
}
