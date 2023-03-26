import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/api_caller/todo_utils.dart';
import 'package:rnd_flutter_app/model/todos_model.dart';
import 'package:rnd_flutter_app/utils/todo_response.dart';

class TodoProvider extends ChangeNotifier {
  TodoUtils todoUtils = TodoUtils();

  List<TodoModel> _openTodos = [];
  List<TodoModel> get openTodos => _openTodos;
  void getTodo() async {
    try {
      TodoResponse todosResponse = await todoUtils.getTodos();
      print('todosResponse.todos');
      print(todosResponse.todos);
      _openTodos = todosResponse.todos;
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
