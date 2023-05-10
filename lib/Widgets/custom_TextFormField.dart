import 'package:flutter/material.dart';

class CustomTextFormFiel extends StatelessWidget {
  const CustomTextFormFiel(
      {Key? key,
      required this.title,
      required this.icon,
      this.obscure = false,
      this.onChange,
      this.mLines = 1})
      : super(key: key);

  final String title;
  final Widget icon;
  final bool obscure;
  final int mLines;
  final void Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      obscureText: obscure,
      maxLines: 10,
      minLines: mLines,
      decoration: InputDecoration(
          hintText: title,
          labelText: title,
          prefixIcon: icon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black54,
              ))),
    );
  }
}
