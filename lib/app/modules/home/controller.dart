import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;

  HomeController({required this.taskRepository});

  final tasks = <Task>[].obs;
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;
  final tabIndex = 0.obs;

  @override
  void onInit() {
    tasks.assignAll(taskRepository.readTasks());
    ever(
      tasks,
      (_) => taskRepository.writeTasks(tasks),
    );
    super.onInit();
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  void changeTabIndex(int value) {
    tabIndex.value = value;
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void changeTask(Task? value) {
    task.value = value;
  }

  bool updateTask(String title) {
    var todos = task.value?.todos ?? [];
    if (containTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.value!.copyWith(todos: todos);
    int oldIndex = tasks.indexOf(task.value);
    tasks[oldIndex] = newTask;
    tasks.refresh();
    return true;
  }

  bool containTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  void changeTodos(List<dynamic> value) {
    doingTodos.clear();
    doneTodos.clear();

    for (var i = 0; i < value.length; i++) {
      var todo = value[i];
      if (todo['done']) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTodos(String title) {
    var doingTodo = {'title': title, 'done': false};
    if (doingTodos.any(
      (element) => mapEquals<String, dynamic>(doingTodo, element),
    )) {
      return false;
    }
    var doneTodo = {'title': title, 'done': true};
    if (doneTodos.any(
      (element) => mapEquals<String, dynamic>(doneTodo, element),
    )) {
      return false;
    }
    doingTodos.add(doingTodo);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([...doingTodos, ...doneTodos]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIndex = tasks.indexOf(task.value);
    tasks[oldIndex] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    var doingTodo = {'title': title, 'done': false};
    int index = doingTodos.indexWhere(
      (element) => mapEquals<String, dynamic>(doingTodo, element),
    );
    doingTodos.removeAt(index);
    var doneTodo = {'title': title, 'done': true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }

  void deleteDoneTodos(dynamic todo) {
    int index = doneTodos.indexWhere(
      (element) => mapEquals<String, dynamic>(todo, element),
    );
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodoEmpty(Task task) {
    return task.todos == null || task.todos!.isEmpty;
  }

  int getDoneTodo(Task task) {
    int res = 0;
    for (var i = 0; i < task.todos!.length; i++) {
      if (task.todos![i]['done']) {
        res += 1;
      }
    }
    return res;
  }

  int getTotalTasks() {
    int res = 0;
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        res += tasks[i].todos!.length;
      }
    }
    return res;
  }

  int getTotalDoneTasks() {
    int res = 0;
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        var todos = tasks[i].todos;
        for (var j = 0; j < todos!.length; j++) {
          if (todos[j]['done']) {
            res += 1;
          }
        }
      }
    }
    return res;
  }
}
