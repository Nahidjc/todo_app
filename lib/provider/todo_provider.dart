import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/model/todos_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<TodoModel> _todoList = [];

  List<TodoModel> get allTodoList => _todoList;

  void addTodoList(TodoModel todo) {
    _todoList.add(todo);
    notifyListeners();
  }

  void removeTodoList(TodoModel todo) {
    final index = _todoList.indexOf(todo);
    _todoList.removeAt(index);
    notifyListeners();
  }
}
