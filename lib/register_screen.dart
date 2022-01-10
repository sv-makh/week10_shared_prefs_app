import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week10_shared_prefs_app/custom_decor.dart';

//экран регистрации
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //логин и пароль пользователя для регистрации
  String _username = '';
  String _password = '';

  final _formKey = GlobalKey<FormState>();

  //запись в память данных для регистрации
  Future<void> _register(String username, String password) async {
    var _p = await SharedPreferences.getInstance();
    _p.setString('username', username);
    _p.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register'), centerTitle: true),
      backgroundColor: Colors.greenAccent,
      //запрет изменения размера формы если открыта клавиатура
      //(чтобы избежать ошибки renderflex overflowed)
      //не нужно, т.к. прокручивание SingleChildScrollView лучше
      //resizeToAvoidBottomInset : false,
      body: Form(
          key: _formKey,
          child: Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Stack(alignment: Alignment.topCenter, children: [
                Container(
                    margin: const EdgeInsets.only(top: 40, left: 60, right: 60),
                    padding: const EdgeInsets.all(20.0),
                    decoration: CustomDecor().cardContainerDecoration(),
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32),
                        //поле для ввода логина
                        TextFormField(
                            decoration: CustomDecor()
                                .textFieldInputDecoration('username (any)'),
                            textAlign: TextAlign.center,
                            onChanged: (value) => _username = value,
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'please enter username';
                            }),
                        const SizedBox(height: 12.0),
                        //поле для ввода пароля
                        TextFormField(
                            decoration: CustomDecor()
                                .textFieldInputDecoration('password (any)'),
                            textAlign: TextAlign.center,
                            obscureText: true,
                            onChanged: (value) => _password = value,
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'please enter password';
                            }),
                        const SizedBox(height: 12.0),
                        //поле для подтверждения пароля
                        TextFormField(
                            decoration: CustomDecor()
                                .textFieldInputDecoration('repeat password'),
                            textAlign: TextAlign.center,
                            obscureText: true,
                            validator: (value) {
                              //пароль должен совпадать с уже введённым
                              if (value != _password)
                                return 'please repeat password';
                            }),
                        const SizedBox(height: 12.0),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  //если все поля заполнены верно
                                  if (_formKey.currentState!.validate()) {
                                    //данные для регистрации записываются в память
                                    _register(_username, _password);
                                    //и просходит переход на экран входа
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Register'))),
                      ],
                    ))),
                //иконка сверху
                CustomDecor().iconInCircle(context, Icons.edit),
              ]))),
    );
  }
}
