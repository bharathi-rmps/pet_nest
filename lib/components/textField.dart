import 'package:flutter/material.dart';

class textField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;

  const textField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.labelText,
  });

  @override
  State<textField> createState() => _textFieldState();
}

class _textFieldState extends State<textField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          labelText: widget.labelText + " *",
          hintText: widget.hintText,
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null, // No toggle button for non-password fields
        ),
      ),
    );
  }
}
