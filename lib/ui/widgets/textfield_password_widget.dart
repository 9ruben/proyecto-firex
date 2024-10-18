import 'package:firetask/ui/general/colors.dart';
import 'package:flutter/material.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  final TextEditingController controller;

  TextFieldPasswordWidget({
    required this.controller,
  });

  @override
  State<TextFieldPasswordWidget> createState() => _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {
  bool isInvisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isInvisible,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
        prefixIcon: Icon(
          Icons.lock,
          size: 20.0,
          color: primary.withOpacity(0.6),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isInvisible ? Icons.visibility : Icons.visibility_off,
            color: primary.withOpacity(0.60),
          ),
          onPressed: () {
            setState(() {
              isInvisible = !isInvisible;
            });
          },
        ),
        hintText: "Contraseña",
        hintStyle: TextStyle(
          fontSize: 14.0,
          color: primary.withOpacity(0.6),
        ),
        filled: true,
        fillColor: secondary,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (String? value) {
        if (value != null && value.isEmpty) {
          return "Campo obligatorio";
        }
        return null;
      },
    );
  }
}
