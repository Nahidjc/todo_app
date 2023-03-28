import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:rnd_flutter_app/model/todos_model.dart';

class TodoUtils {
  Future<List<TodoModel>> getTodos() async {
    try {
      var response = await http.get(
          Uri.parse('https://e-commerce-service-node.onrender.com/todo/all'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> rawTodos = data['todos'];
        List<TodoModel> todosData =
            List.from(rawTodos.map((e) => TodoModel.fromJson(e)));
        return todosData;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error');
    }
  }
}
