import 'package:dummy_6/model/student_model.dart';
import 'package:hive/hive.dart';

class StudentService {
  final Box<StudentModel> studentbox = Hive.box<StudentModel>("List");

  Future<void> addData(StudentModel stuent) async {
    await studentbox.add(stuent);
  }

  List<StudentModel> valueList() {
    return studentbox.values.toList();
  }

  Future<void> update(int index, StudentModel student) async {
    await studentbox.putAt(index, student);
  }

  Future<void> delete(int index) async {
    await studentbox.deleteAt(index);
  }
}
