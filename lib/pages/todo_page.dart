import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/pages/login_page.dart';
import 'package:rnd_flutter_app/provider/todo_provider.dart';

class Todo {
  final String task;
  final DateTime dueDate;
  bool isCompleted;
  bool isPublic;

  Todo(
      {required this.task,
      required this.dueDate,
      this.isCompleted = false,
      this.isPublic = true});
}

class ToDoTable extends StatefulWidget {
  const ToDoTable({super.key});
  @override
  State<ToDoTable> createState() => _ToDoTableState();
}

class _ToDoTableState extends State<ToDoTable> {
  late List<Todo> todos = [
    Todo(
        task: 'Buy groceries',
        dueDate: DateTime.now().add(const Duration(days: 0)),
        isCompleted: true,
        isPublic: true),
    Todo(
        task: 'Pay bills',
        dueDate: DateTime.now().add(const Duration(days: 7)),
        isCompleted: true,
        isPublic: false),
    Todo(
        task: 'Clean house',
        dueDate: DateTime.now().add(const Duration(days: 1)),
        isCompleted: false,
        isPublic: true),
  ];

  late List<Todo> publicTodos =
      todos.where((todo) => todo.isPublic == true).toList();
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    print(todoProvider.openTodos.length);
    return Scaffold(
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
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 253, 253, 253)),
            child: SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Task')),
                  DataColumn(label: Text('Due Date')),
                  DataColumn(label: Text('Status')),
                ],
                rows: publicTodos.map((todo) {
                  return DataRow(cells: [
                    DataCell(
                      Text(todo.task,
                          style: todo.isCompleted
                              ? const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2.0,
                                  decorationColor:
                                      Color.fromARGB(255, 243, 42, 27),
                                  color: Color.fromARGB(255, 13, 13, 13),
                                )
                              : const TextStyle()),
                    ),
                    DataCell(
                        Text(todo.dueDate.toLocal().toString().split(' ')[0])),
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
          ))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TodoUtils todoUtils = TodoUtils();
          // todoUtils.getTodos();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
