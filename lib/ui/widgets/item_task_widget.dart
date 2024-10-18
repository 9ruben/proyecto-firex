import 'package:firetask/models/task_model.dart';
import 'package:firetask/services/my_service_firestore.dart';
import 'package:firetask/ui/widgets/item_category_widget.dart';
import 'package:flutter/material.dart';

import '../general/colors.dart';
import 'general_widgets.dart';

class ItemTaskWidget extends StatelessWidget {
  final TaskModel taskModel;

  ItemTaskWidget({required this.taskModel});

  final MyServiceFirestore _myServiceFirestore = MyServiceFirestore(collection: "tasks");

  void showFinishedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Finalizar tarea"),
          content: Text("La tarea ha sido marcada como finalizada."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text("Aceptar"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _myServiceFirestore.finishedTask(taskModel.id!);
                  Navigator.of(context).pop(); 
                } catch (e) {
                  // Manejo de errores (puedes mostrar un snackbar, por ejemplo)
                  showSnackBarError(context, "Error al finalizar la tarea");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text("Finalizar", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(4, 4),
              blurRadius: 12
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemCategoryWidget(text: taskModel.category),
              caja3(),
              Text(
                taskModel.title,
                style: TextStyle(
                  decoration: taskModel.status ? TextDecoration.none : TextDecoration.lineThrough,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: primary.withOpacity(0.85),
                ),
              ),
              Text(
                taskModel.description,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primary.withOpacity(0.75),
                ),
              ),
              caja6(),
              Text(
                taskModel.date,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primary.withOpacity(0.75),
                ),
              ),
            ],
          ),
          Positioned(
            top: -10,
            right: -12,
            child: PopupMenuButton(
              elevation: 2,
              color: Colors.white,
              icon: Icon(Icons.more_vert, color: primary.withOpacity(0.85)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              onSelected: (value) {
                if (value == 2) {
                  showFinishedDialog(context);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Text('Editar'),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text('Finalizar'),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
    );
  }
}
