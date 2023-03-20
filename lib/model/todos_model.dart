class TodoModel {
  final String task;
  final DateTime dueDate;
  bool isCompleted;
  bool isPublic;

  TodoModel(
      {required this.task,
      required this.dueDate,
      this.isCompleted = false,
      this.isPublic = true});
}
