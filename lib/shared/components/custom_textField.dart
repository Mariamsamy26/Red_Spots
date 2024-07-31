import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  String hintText;
  TextInputType keyboardType;
  String? Function(String?) validator;
  bool obscureText;
  String labelText;
  Function(String)? onChanged;
  TextEditingController? titleController;
  final TextInputFormatter? lengthLimitFormatter;
  final TextInputFormatter? numericFilterFormatter;

  CustomTextField({
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.validator,
    required this.labelText,
    this.onChanged,
    required this.titleController,
    this.lengthLimitFormatter,
    this.numericFilterFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color.fromRGBO(239, 239, 239, 1))),
      ),
      validator: validator,
      inputFormatters: [
        if (lengthLimitFormatter != null) lengthLimitFormatter!,
        if (numericFilterFormatter != null) numericFilterFormatter!,
      ],
    );
  }
}

