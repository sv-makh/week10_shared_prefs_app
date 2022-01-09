import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _username = '';
  String _password = '';

  final _formKey = GlobalKey<FormState>();

  Future<void> _register(String username, String password) async {
    var _p = await SharedPreferences.getInstance();
    _p.setString('username', username);
    _p.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register'), centerTitle: true),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  decoration: InputDecoration(hintText: 'username (any)'),
                  onChanged: (value) => _username = value,
                  validator: (value) {
                    if (value!.isEmpty) return 'please enter username';
                  }
              ),
              TextFormField(
                  decoration: InputDecoration(hintText: 'password (any)'),
                  obscureText: true,
                  onChanged: (value) => _password = value,
                  validator: (value) {
                    if (value!.isEmpty) return 'please enter password';
                  }
              ),
              TextFormField(
                  decoration: InputDecoration(hintText: 'repeat password'),
                  obscureText: true,
                  validator: (value) {
                    if (value != _password) return 'please repeat password';
                  }
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _register(_username, _password);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Register')
              ),
            ],
          )
      ),
    );
  }
}