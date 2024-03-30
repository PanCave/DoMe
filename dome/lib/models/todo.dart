class Todo {
  String title;
  String description;
  bool isDone;
  DateTime dueDate;

  Todo(
    {
      required this.title,
      required this.description,
      required this.dueDate,
      this.isDone = false,
    }
  );

  Todo.fromJson(Map<String, dynamic> json)
    : title = json['title'] ?? 'Unbekannter Titel',
    description = json['description'] ?? 'Unbekannte Beschreibung',
    dueDate = DateTime.tryParse(json['dueDate'] ?? '') ?? DateTime.now().add(const Duration(days: 1)),
    isDone = json['isDone'] ?? false;
  
  Map<String, dynamic> toJson() => {
    'title' : title,
    'description' : description,
    'dueDate' : dueDate.toString(),
    'isDone' : isDone
  };
}