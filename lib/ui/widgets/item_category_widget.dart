import 'package:firetask/ui/general/colors.dart';
import 'package:flutter/material.dart';

class ItemCategoryWidget extends StatelessWidget {
  final String text;

  ItemCategoryWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    // Obtener el color correspondiente, con un valor predeterminado si no se encuentra.
    final color = categoryColor[text] ?? Colors.grey; // Color predeterminado

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
