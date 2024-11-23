import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomeTextFieldWidget extends StatelessWidget{

  final String hintText;
  final String? lableText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;



  const CustomeTextFieldWidget({

    required this.hintText,
    this.lableText,
    this.prefixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureText = false,

  } ) ;





  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration:
      InputDecoration(
        hintText: hintText,
        labelText: lableText,
          prefixIcon: prefixIcon !=null ? Icon(prefixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent,
          width: 2.0,
        ),
      ),enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(21),
        borderSide: (BorderSide(
          color: Colors.black,
          width: 1
        ))
      ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16)
      ),
    );
  }

}