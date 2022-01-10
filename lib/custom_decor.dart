import 'package:flutter/material.dart';

class CustomDecor {
  //дизайн для карточки формы:
  //цвет, скругление углов и тень
  BoxDecoration cardContainerDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [BoxShadow(
            color: Colors.brown,
            spreadRadius: 20,
            blurRadius: 10,
            //смещение тени вниз и вправо
            offset: Offset(20,20)
        )]
    );
  }

  //дизайн для полей ввода логина и пароля:
  //цвет, скругление углов и цвет границ
  InputDecoration textFieldInputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey)
      ),
    );
  }

  //иконка в круге сверху карточки формы
  //Icons.person для Sign In экрана
  //Icons.edit для Register экрана
  //круг, тень круга, сама иконка и её тень
  Widget iconInCircle(BuildContext context, IconData icon) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.yellow,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.brown,
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: Offset(5,5)
              )
            ]
        ),
        width: 65.0,
        height: 65.0,
        //преобразование иконки в текст это способ сделать тень от неё
        child: Center( child: Text(
            String.fromCharCode(icon.codePoint),
            style: TextStyle(
                fontFamily: icon.fontFamily,
                color: Colors.white,
                fontSize: 40.0,
                shadows: const [
                  BoxShadow(
                      color: Colors.brown,
                      spreadRadius: 20,
                      blurRadius: 10,
                      offset: Offset(5,5)
                  )
                ],
                height: 1 //if this isn't set, the shadow will be cut off on the top and bottom
            )
        ))
    );
  }
}