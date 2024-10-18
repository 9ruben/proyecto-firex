import 'package:firetask/models/task_model.dart';
import 'package:firetask/ui/widgets/item_task_widget.dart';
import 'package:flutter/material.dart';

class TaskSearchDelegate extends SearchDelegate {
  final List<TaskModel> tasks;

  TaskSearchDelegate({required this.tasks});

  @override
  String? get searchFieldLabel => "Buscar tarea...";

  @override
  TextStyle? get searchFieldStyle => TextStyle(
        fontSize: 16.0,
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSuggestionsOrResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSuggestionsOrResults();
  }

  Widget _buildSuggestionsOrResults() {
    List<TaskModel> results = tasks
        .where((task) => task.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          "No se encontraron tareas.",
          style: TextStyle(fontSize: 16.0, color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemTaskWidget(
            taskModel: results[index],
          );
        },
      ),
    );
  }
}
