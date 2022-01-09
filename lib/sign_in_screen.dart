import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week10_shared_prefs_app/design.dart';

//экран входа
class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //контроллеры для TextField с логином и паролем
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  //переменные для хранения того, что введёт/отметит пользователь
  //логин
  String _username = '';
  //пароль
  String _password = '';
  //надо ли запоминать логин и пароль при успешном входе 
  bool _signInCheck = false;

  //метод для заполнения экрана при его загрузке
  Future<void> _loadFields() async {
    var _p = await SharedPreferences.getInstance();
    //условие заполнения хранится в памяти
    bool _signIn = _p.getBool('signInCheck') ?? false;
    //заполнение происходит, только если хранится значение true
    if (_signIn == true) {
      setState(() {
        _usernameController = TextEditingController(text: _p.getString('username'));
        _passwordController = TextEditingController(text: _p.getString('password'));
        _signInCheck = true;
      });
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
    return _signedIn;
  }

  Future<void> _signInRemember(bool signInCheck) async {
    var _p = await SharedPreferences.getInstance();
    _p.setBool('signInCheck', signInCheck);
  }

  Future<void> _signOut() async {
    var _p = await SharedPreferences.getInstance();
    _p.remove('username');
    _p.remove('password');
    _p.remove('signInCheck');

    setState(() {
      _usernameController.clear();
      _passwordController.clear();
      _signInCheck = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sign In'), centerTitle: true),
        backgroundColor: Colors.deepOrangeAccent,
        resizeToAvoidBottomInset : false,
        body: Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
            margin: const EdgeInsets.only(top: 40, left: 60, right: 60),
            padding: const EdgeInsets.all(20.0),
            decoration: CustomDecor().cardContainerDecoration(),/*BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const [BoxShadow(
                  color: Colors.brown,
                  spreadRadius: 20,
                  blurRadius: 10,
                  offset: Offset(20,20)
              )]
            ),*/
            //color: Colors.white,
            child: SingleChildScrollView( child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              TextField(
                controller: _usernameController,
                textAlign: TextAlign.center,
                decoration: CustomDecor().textFieldInputDecoration('username'),
                  onChanged: (value) => _username = value,
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _passwordController,
                textAlign: TextAlign.center,
                decoration: CustomDecor().textFieldInputDecoration('password'),
                obscureText: true,
                onChanged: (value) => _password = value,
              ),
              CheckboxListTile(
                  value: _signInCheck,
                  title: const Text('Remember me'),
                  onChanged: (bool? value) => setState(() {
                    _signInCheck = value!;
                  })
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _signIn(_usernameController.text, _passwordController.text)
                        .then((value) {
                      if (value == true) {
                        _signInRemember(_signInCheck);
                        _showGreeting(context, _usernameController.text);
                      }
                      else { Navigator.pushNamed(context, '/register'); }
                    });
                  },
                  child: const Text('Sign In'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      _signOut();
                    },
                    child: const Text('Sign Out')
                ),
              ),

            ],
          ),)
        ),
        CustomDecor().iconInCircle(context, Icons.person),
        ]
      )
      )
    );
  }

  _showGreeting(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hello'),
        content: Text(name),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok')
          )
        ],
      ),
      barrierDismissible: false,
    );
  }
}

