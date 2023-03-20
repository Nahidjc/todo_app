import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/pages/login_page.dart';

class Todo {
  final String task;
  final DateTime dueDate;
  bool isCompleted;

  Todo({required this.task, required this.dueDate, this.isCompleted = false});
}

class ToDoTable extends StatefulWidget {
  const ToDoTable({super.key});
  @override
  State<ToDoTable> createState() => _ToDoTableState();
}

class _ToDoTableState extends State<ToDoTable> {
  final List<Todo> todos = [
    Todo(
        task: 'Buy groceries',
        dueDate: DateTime.now().add(const Duration(days: 0)),
        isCompleted: true),
    Todo(
        task: 'Pay bills',
        dueDate: DateTime.now().add(const Duration(days: 7)),
        isCompleted: true),
    Todo(
        task: 'Clean house',
        dueDate: DateTime.now().add(const Duration(days: 1)),
        isCompleted: true),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('TODO Table'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Task')),
            DataColumn(label: Text('Due Date')),
            DataColumn(label: Text('Status')),
          ],
          rows: todos.map((todo) {
            return DataRow(cells: [
              DataCell(Text(todo.task)),
              DataCell(Text(todo.dueDate.toLocal().toString().split(' ')[0])),
              DataCell(Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      todo.isCompleted = value!;
                    });
                  })),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
