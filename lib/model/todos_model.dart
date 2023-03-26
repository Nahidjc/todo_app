import 'dart:convert';

List<TodoModel> todoFromJson(String str) =>
    List<TodoModel>.from(json.decode(str).map((x) => TodoModel.fromJson(x)));

String todoToJson(List<TodoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoModel {
  String? id;
  String? author;
  String? todo;
  bool? isPublic;
  bool? isCompleted;

  TodoModel({this.id, this.author, this.todo, this.isPublic, this.isCompleted});

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
      id: json['_id'],
      author: json['author'],
      todo: json['todo'],
      isPublic: json['isPublic'],
      isCompleted: json['isCompleted']);

  Map<String, dynamic> toJson() => {
        '_id': id,
        'author': author,
        'todo': todo,
        'isPublic': isPublic,
        'isCompleted': isCompleted
      };
}
