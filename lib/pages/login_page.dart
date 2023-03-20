import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rnd_flutter_app/pages/todo_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailText = TextEditingController();
  final TextEditingController _passwordText = TextEditingController();
  bool isLoading = false;
  login(String email, password) async {
    try {
      _emailText.clear();
      _passwordText.clear();
      setState(() {
        isLoading = true;
      });
      var response = await http
          .post(
            Uri.parse(
                'https://e-commerce-service-node.onrender.com/user/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
                <String, String>{'email': email, 'password': password}),
          )
          .then((value) => value.body);
      var data = jsonDecode(response);
      setState(() {
        isLoading = false;
      });
      if (data['statusCode'] == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ToDoTable()),
        );
      } else {
        throw data["message"];
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ToDoTable()),
                    );
                  },
                  child: const Text(
                    'Todo',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailText,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 20),
                          prefixIcon: Icon(Icons.email)),
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _passwordText,
                      obscureText: true,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          labelStyle: TextStyle(fontSize: 20)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      height: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10),
                          //internal content margin
                        ),
                        onPressed: () {
                          var email = _emailText.text;
                          var password = _passwordText.text;
                          login(email, password);
                        },
                        child:
                            const Text('Login', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?",
                            style: TextStyle(fontSize: 16)),
                        TextButton(
                            onPressed: () {

                            },
                            child: const Text("Sign Up",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
