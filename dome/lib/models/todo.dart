class Todo {
  String title;
  String description;
  bool isDone;

  Todo(
    {
      required this.title,
      required this.description,
      this.isDone = false,
    }
  );

  Todo.fromJson(Map<String, dynamic> json)
    : title = json['title'],
    description = json['description'],
    isDone = json['isDone'];
  
  Map<String, dynamic> toJson() => {
    'title' : title,
    'description' : description,
    'isDone' : isDone
  };
}