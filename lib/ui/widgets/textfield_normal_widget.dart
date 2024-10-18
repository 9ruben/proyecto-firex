import 'package:flutter/material.dart';

import '../general/colors.dart';

class TextfieldNormalWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final VoidCallback? onTap; // Cambiado a VoidCallback
  final TextEditingController controller;
  final String? Function(String?)? validator; // Validator opcional

  TextfieldNormalWidget({
    required this.hintText,
    required this.icon,
    this.onTap,
    required this.controller,
    this.validator, // Constructor
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: onTap != null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        prefixIcon: Icon(
          icon,
          size: 20,
          color: primary,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: primary.withOpacity(0.6),
        ),
        filled: true,
        fillColor: secondary,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.red, // Color del borde de error
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.red, // Color del borde de error enfocado
          ),
        ),
      ),
      validator: validator ?? (String? value) {
        if (value != null && value.isEmpty) {
          return "Campo Obligatorio";
        }
        return null;
      },
    );
  }
}


