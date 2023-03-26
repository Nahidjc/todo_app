class TodoModel {
  String? sId;
  String? author;
  String? todo;
  bool? isPublic;
  bool? isCompleted;

  TodoModel(
      {this.sId, this.author, this.todo, this.isPublic, this.isCompleted});

  TodoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'];
    todo = json['todo'];
    isPublic = json['isPublic'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['author'] = author;
    data['todo'] = todo;
    data['isPublic'] = isPublic;
    data['isCompleted'] = isCompleted;
    return data;
  }
}
