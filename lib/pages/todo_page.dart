import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/model/todos_model.dart';
import 'package:rnd_flutter_app/pages/login_page.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';
import 'package:rnd_flutter_app/provider/todo_provider.dart';
import 'package:intl/intl.dart';

class ToDoTable extends StatefulWidget {
  const ToDoTable({super.key});
  @override
  State<ToDoTable> createState() => _ToDoTableState();
}

class _ToDoTableState extends State<ToDoTable> {
  final formKey = GlobalKey<FormState>();
  bool isPublic = true;
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController todoinput = TextEditingController();

  Future<void> showTodoFormDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Create Todo'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: todoinput,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Todo',
                          hintText: 'Enter todo name',
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: dateinput,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.calendar_today),
                            labelText: "Enter Deadline"),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100));
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              dateinput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: isPublic,
                            onChanged: (checked) {
                              setState(() {
                                if (checked != null) {
                                  isPublic = checked;
                                }
                              });
                            },
                          ),
                          const Text('Public todo'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add Todo'),
                ),
              ],
            );
          });
        });
  }

  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().getTodo();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final todoProvider = Provider.of<TodoProvider>(context);
    List<TodoModel> pubTodos = [];
    if (authProvider.isAuthenticate) {
      pubTodos = todoProvider.openTodos;
    } else {
      pubTodos = todoProvider.openTodos
          .where((todo) => todo.isPublic == true)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO Table'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          authProvider.isAuthenticate
              ? IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => authProvider.logout(),
                )
              : TextButton(
                  child: const Text('Login',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  }),
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
        onPressed: () =>
            authProvider.isAuthenticate ? showTodoFormDialog(context) : null,
        backgroundColor:
            authProvider.isAuthenticate ? Colors.blue : Colors.grey,
        tooltip: 'Create Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
