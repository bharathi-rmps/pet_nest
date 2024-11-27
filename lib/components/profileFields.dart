import 'package:flutter/material.dart';

class profileFields extends StatelessWidget {
  const profileFields({
    super.key,
    required this.title,
    required this.subTitle,
    required this.isObscured
    });

  final String title;
  final String subTitle;
  final bool isObscured;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              isObscured ? '*' * subTitle.length : subTitle,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}