import 'package:flutter/material.dart';
class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const MyTextField({super.key, required this.hintText,required this.obscureText,required this.controller});
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      obscureText: obscureText,
    style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}