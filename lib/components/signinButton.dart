import 'package:flutter/material.dart';

class signinButton extends StatelessWidget {
  final Function()? onTap;
  const signinButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.deepOrangeAccent,
          borderRadius: BorderRadius.circular(10),
            ),
          child: const Center(child: Text(
            "Log In", style: TextStyle(
              color: Colors.white,
              fontSize: 17,
          fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}