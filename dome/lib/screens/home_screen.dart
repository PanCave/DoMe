import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dome/models/todo.dart';
import 'package:dome/models/agenda.dart';
import 'package:dome/screens/edit_todo_dialog.dart';
import 'package:dome/screens/agenda_screen.dart';
import 'package:dome/screens/error_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Agenda agenda;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAgenda();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: isLoading ? const Center(
        child: CircularProgressIndicator()
      ) : AgendaScreen(agenda: agenda),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        tooltip: 'Neue Aufgabe hinzufügen',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _loadAgenda() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('agenda');
    try {
      if(jsonString == null) {
        agenda = Agenda(agenda: []);
      } else {
        // agenda = Agenda(agenda: []);
        final jsonMap = json.decode(jsonString);
        agenda = Agenda.fromJson(jsonMap);
      }
    } catch (e) {
      // ignore: avoid_print
      print("Ein Fehler ist aufgetrete: $e");
      await _showErrorDialog();
      agenda = Agenda(agenda: []);
    }
    finally {
      setState(() {
        isLoading = false;
      });
    }

  }

  Future<void> _saveAgenda() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(agenda.toJson());
    prefs.setString('agenda', jsonString);
  }

  void _addTodoToAgenda(String title, String description) {
    setState(() {
      agenda.agenda.add(Todo(title: title, description: description));
    });
    _saveAgenda();
  }

  Future<void> _showErrorDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ErrorDialog(errorMessage: "Beim Laden ist ein Fehler aufgetreten.");
      },
    );
  }
  
  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditTodoDialog(
          onTodoEdited: (title, description) {
            _addTodoToAgenda(title, description);
          },
          editButtonText: 'Hinzufügen',
        );
      },
    );
  }

  
}
