import 'package:get/get.dart';
import 'package:myapp/db/db_helper.dart';
import 'package:myapp/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  final RxList<Task> taskList = List<Task>.empty().obs;

  // add data
  Future<void> addTask({required Task task}) async {
    await DBHelper.insert(task);
  }

  // get all data
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  // delete
  void deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  // update
  void markTaskCompleted(int? id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
