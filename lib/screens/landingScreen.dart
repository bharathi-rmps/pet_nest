import 'package:flutter/material.dart';

class landingScreen extends StatelessWidget{
  landingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.grey,
          body: SafeArea(
              child: Center(
                child: Text(
                  "Welcome to Pet Nest!"
                ),
          ),
      ),
    );
  }
}