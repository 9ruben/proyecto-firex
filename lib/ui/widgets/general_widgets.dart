import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../general/colors.dart';

// Widget para tamaños verticales.
Widget caja(double height) => SizedBox(height: height);

// Carga un widget de carga
Widget loadingWidget() => Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: primary,
          strokeWidth: 2.2,
        ),
      ),
    );

// Muestra un SnackBar de éxito.
void showSnackBarSuccess(BuildContext currentContext, String text) {
  ScaffoldMessenger.of(currentContext).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0xFF17c3b2),
      content: Row(
        children: [
          const Icon(Icons.check, color: Colors.white),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    ),
  );
}

// Muestra un SnackBar de error.
void showSnackBarError(BuildContext currentContext, String text) {
  ScaffoldMessenger.of(currentContext).showSnackBar(
    SnackBar(
      backgroundColor: Colors.redAccent,
      content: Row(
        children: [
          const Icon(Icons.warning_amber, color: Colors.white),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    ),
  );
}
