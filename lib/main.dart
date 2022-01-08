import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => SignInScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);
}

class Authentication {
  final Future<SharedPreferences> prefs;
  bool _signedIn = false;

  Authentication(this.prefs);

  Future<bool> signIn(String username, String password) async {
    var _p = await prefs;
    if ((_p.getString('username') == username) &&
        (_p.getString('password') == password)) {
      _signedIn = true;
    }
    else {
      _signedIn = false;
    }
    return _signedIn;
  }
}

Future<bool> _signIn(String username, String password) async {
  bool _signedIn = false;
  var _p = await SharedPreferences.getInstance();
  if ((_p.getString('username') == username) &&
      (_p.getString('password') == password)) {
    _signedIn = true;
  }
  else {
    _signedIn = false;
  }
  _printCr(_p);
  print('_signedIn: $_signedIn');
  return _signedIn;
}

Future<void> _signOut() async {
  var _p = await SharedPreferences.getInstance();
  _p.remove('username');
  _p.remove('password');
  _p.remove('signInCheck');
  _printCr(_p);
}

Future<void> _register(String username, String password) async {
  var _p = await SharedPreferences.getInstance();
  _p.setString('username', username);
  _p.setString('password', password);
  _printCr(_p);
}

Future<void> _signInRemember(bool signInCheck) async {
  var _p = await SharedPreferences.getInstance();
  _p.setBool('signInCheck', signInCheck);
}

void _printCr(SharedPreferences _p) {
  print('username:');
  print(_p.getString('username'));
  print('password:');
  print(_p.getString('password'));
  print('signInCheck');
  print(_p.getBool('signInCheck'));
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  String _username = '';
  String _password = '';
  bool _signInCheck = false;

  Future<void> _loadFields() async {
    var _p = await SharedPreferences.getInstance();
    bool _signIn = _p.getBool('signInCheck') ?? false;
    _printCr(_p);
    if (_signIn == true) {
      setState(() {
        _usernameController = TextEditingController(text: _p.getString('username'));
        _passwordController = TextEditingController(text: _p.getString('password'));
        _signInCheck = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(hintText: 'username (any)'),
                onChanged: (value) => _username = value,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(hintText: 'password (any)'),
                obscureText: true,
                onChanged: (value) => _password = value,
              ),
              CheckboxListTile(
                value: _signInCheck,
                title: Text('Remember me'),
                onChanged: (bool? value) => setState(() {
                  _signInCheck = value!;
                })
              ),
              ElevatedButton(
                onPressed: () {
                  _signIn(_usernameController.text, _passwordController.text).then((value) {
                    if (value == true) {
                      _signInRemember(_signInCheck);
                      showGreeting(context, _usernameController.text);
                    }
                    else { Navigator.pushNamed(context, '/register'); }
                  });
                },
                child: Text('Sign In'),
              ),
              ElevatedButton(
                onPressed: () {
                  _signOut();
                  setState(() {
                    _usernameController.clear();
                    _passwordController.clear();
                    _signInCheck = false;
                  });
                },
                child: Text('Sign Out')
              )
            ],
          ),
        )
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _username = '';
  String _password = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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

showGreeting(BuildContext context, String name) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Hello'),
      content: Text(name),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Ok')
        )
      ],
    ),
    barrierDismissible: false,
  );
}