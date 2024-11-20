import 'package:flutter/material.dart';

class button extends StatelessWidget {
  final Function()? onTap;

  const button({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(10),
            ),
          child: const Center(child: Text(
            'Sign In', style: TextStyle(
              fontSize: 17,
          fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}