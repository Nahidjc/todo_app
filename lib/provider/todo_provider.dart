import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/api_caller/todo_utils.dart';
import 'package:rnd_flutter_app/model/todos_model.dart';

class TodoProvider extends ChangeNotifier {
  // Map<String, dynamic> allTodo = {};
  // Map<String, dynamic> get todo => allTodo;
  late List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  void getTodo() async {
    try {
      TodoUtils todoUtils = TodoUtils();
      // _todos = await todoUtils.getTodos();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  // void addTodoList(TodoModel todo) {
  //   _todoList.add(todo);
  //   notifyListeners();
  // }

  // void removeTodoList(TodoModel todo) {
  //   final index = _todoList.indexOf(todo);
  //   _todoList.removeAt(index);
  //   notifyListeners();
  // }
}
