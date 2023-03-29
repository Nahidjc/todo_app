import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/pages/todo_page.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';
import 'package:rnd_flutter_app/provider/todo_provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider())],
        child: const MaterialApp(
          title: "Flutter APP",
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              backgroundColor: Colors.white, body: Center(child: MyApp())),
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: ToDoTable(),
      ),
    );
  }
}
