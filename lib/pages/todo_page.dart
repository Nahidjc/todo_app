import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/model/todos_model.dart';
import 'package:rnd_flutter_app/pages/login_page.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';
import 'package:rnd_flutter_app/provider/todo_provider.dart';

class ToDoTable extends StatefulWidget {
  const ToDoTable({super.key});
  @override
  State<ToDoTable> createState() => _ToDoTableState();
}

class _ToDoTableState extends State<ToDoTable> {
  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().getTodo();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final todoProvider = Provider.of<TodoProvider>(context);
    final List<TodoModel> pubTodos =
        todoProvider.openTodos.where((todo) => todo.isPublic == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO Table'),
        actions: <Widget>[
          authProvider.isAuthenticate
              ? IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => authProvider.logout(),
                )
              : TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
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
          child: todoProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 0, 162, 255)))
              : DataTable(
                  columns: const [
                    DataColumn(label: Text('Task')),
                    DataColumn(label: Text('Deadline')),
                    DataColumn(label: Text('Done')),
                  ],
                  rows: pubTodos.map((element) {
                    return DataRow(cells: <DataCell>[
                      DataCell(
                        Text(element.todo.toString(),
                            style: element.isCompleted == true
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
                        Text(element.containsKey("dueDate")
                            ? element.dueDate.toString()
                            : DateTime.now().toString()),
                      ),
                      DataCell(Checkbox(
                        value: element.isCompleted,
                        onChanged: (value) {
                          // todoProvider.toggleDone(todo);
                        },
                      )),
                    ]);
                  }).toList(),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoProvider.getTodo();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
