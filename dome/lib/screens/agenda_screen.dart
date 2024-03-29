import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dome/models/agenda.dart';
import 'package:dome/screens/edit_todo_dialog.dart';

class AgendaScreen extends StatefulWidget {
  final Agenda agenda;

  AgendaScreen({
    required this.agenda
  });

  @override
  State<AgendaScreen> createState() => AgendaScreenState();
}

class AgendaScreenState extends State<AgendaScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemCount: widget.agenda.agenda.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                _showEditTodoDialog(index);
              },
              title: Text(widget.agenda.agenda[index].title),
              subtitle: Text(widget.agenda.agenda[index].description),
              trailing: Checkbox(
                value: widget.agenda.agenda[index].isDone,
                onChanged: (bool? value) {
                  setState(() {
                    widget.agenda.agenda[index].isDone = value ?? false;
                  });
                  _saveAgenda();
                },
              ),
            );
          });
  }

  Future<void> _saveAgenda() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(widget.agenda.toJson());
    prefs.setString('agenda', jsonString);
  }

  void _editTodo(String title, String description, int todoIndex) {
    setState(() {
      widget.agenda.agenda[todoIndex].title = title;
      widget.agenda.agenda[todoIndex].description = description;
    });
    _saveAgenda();
  }

  void _showEditTodoDialog(int todoIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditTodoDialog(
          onTodoEdited: (title, description) {
            _editTodo(title, description, todoIndex);
          },
          editButtonText: 'Aktualisieren',
          title: widget.agenda.agenda[todoIndex].title,
          description: widget.agenda.agenda[todoIndex].description,
        );
      });
  }

}