import 'package:flutter/material.dart';

class CustomDecor {
  BoxDecoration cardContainerDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [BoxShadow(
            color: Colors.brown,
            spreadRadius: 20,
            blurRadius: 10,
            offset: Offset(20,20)
        )]
    );
  }

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

  //Icons.person для Sign In
  //Icons.edit для Register
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