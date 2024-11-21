import 'package:flutter/material.dart';

class textField extends StatelessWidget{
  final controller;
  final String hintText;
  final String labelText;
  final bool obscureText;

  const textField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this. labelText,
  });

  @override
  Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal:25),
       child: TextField(
         controller: controller,
         obscureText: obscureText,
         decoration: InputDecoration(
           labelText: labelText,
           hintText: hintText,
         ),
       ),
     );
  }
}