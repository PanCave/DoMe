import 'package:dome/models/todo.dart';

class Agenda {
  List<Todo> agenda;

  Agenda({
    required this.agenda
  });

  Agenda.fromJson(Map<String, dynamic> json)
    : agenda = (json['agenda'] as List)
          .map((item) => Todo.fromJson(item as Map<String, dynamic>))
          .toList();

  Map<String, dynamic> toJson() => {
    'agenda' : agenda
      .map((item) => item.toJson()).toList()
  };
}