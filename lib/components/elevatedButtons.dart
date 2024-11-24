import 'package:flutter/material.dart';

class elevatedButtons extends StatelessWidget {
  final void Function()? onPressed;
  final String data;
  final color;
  final double size;

  const elevatedButtons({
    super.key,
    required this.onPressed,
    required this.data,
    required this.color,
    required this.size,
});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(
      data,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold
      ),
    ));
  }

}