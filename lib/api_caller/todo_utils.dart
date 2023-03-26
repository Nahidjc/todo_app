import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:rnd_flutter_app/model/todos_model.dart';
import 'package:rnd_flutter_app/utils/todo_response.dart';

class TodoUtils {
  Future<TodoResponse> getTodos() async {
    try {
      var response = await http.get(
          Uri.parse('https://e-commerce-service-node.onrender.com/todo/all'));
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> rawTodos = data['todos'];
      List<TodoModel> todos = todoFromJson(json.encode(rawTodos));
      return TodoResponse(todos);
    } catch (e) {
      throw 'Error';
    }
  }
}
