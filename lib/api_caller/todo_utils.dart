import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rnd_flutter_app/model/todos_model.dart';

class TodoUtils {
  Future<TodoModel> getTodos() async {
    List<TodoModel> todosData = [];
    try {
      var response = await http.get(
          Uri.parse('https://e-commerce-service-node.onrender.com/todo/all'));
      var data = jsonDecode(response.body);
      List<dynamic> rawTodos = data['todos'];

      rawTodos.forEach((element) {
        TodoModel todoModel = TodoModel.fromJson(element);
        todosData.add(todoModel);
      });
      return todosData;
    } catch (e) {
      throw Exception('Error');
    }
  }
}

     // if (response.statusCode == 200) {
      //   var data = jsonDecode(response.body);
      //   TodoModel todosModel = TodoModel.fromJson(data['todos']);
      //   return todosModel;
      // } else {
      //   throw Exception('Error');
      // }