class TaskModel {
  String? id;
  String title;
  String description;
  String date;
  String category;
  bool status;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.status,
  });

  // Factory constructor to create an instance from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'], // Mantener el valor original, puede ser null
        title: json["title"],
        description: json["description"],
        date: json["date"],
        category: json["category"],
        status: json["status"],
      );

  // Convert the instance to JSON
  Map<String, dynamic> toJson() => {
        "id": id, // Agregar el id al JSON si existe
        "title": title,
        "description": description,
        "date": date,
        "category": category,
        "status": status,
      };
}