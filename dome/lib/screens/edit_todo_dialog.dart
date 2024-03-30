import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class EditTodoDialog extends StatefulWidget {
  final Function(String, String, DateTime) onTodoEdited;
  final String editButtonText;
  String title, description;
  DateTime dueDate;
  
  EditTodoDialog({
    Key? key,
    required this.onTodoEdited,
    required this.editButtonText,
    this.title = '',
    this.description = '',
    DateTime? dueDate,
  }) : 
    dueDate = dueDate ?? DateTime.now().add(const Duration(days: 1)),
    super(key: key);

  @override
  State<EditTodoDialog> createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = DateFormat('dd. MMMM yyyy', 'de_DE').format(widget.dueDate);;
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      title: const Text('Neues Todo hinzufügen'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Titel'),
            onChanged: (value) {
              widget.title = value;
            },
            controller: TextEditingController(text: widget.title),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(labelText: 'Beschreibung'),
            onChanged: (value) {
              widget.description = value;
            },
            controller: TextEditingController(text: widget.description),
          ),
          const SizedBox(height: 20,),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(
              labelText: 'Fällig am:',
              filled: true,
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)
              )
            ),
            readOnly: true,
            onTap: () {
              _selectDueDate();
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Abbrechen'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onTodoEdited(widget.title, widget.description, widget.dueDate);
            Navigator.of(context).pop();
          },
          child: Text(widget.editButtonText),
        ),
      ],
    );
  }

  Future<void> _selectDueDate() async {
    widget.dueDate = await showDatePicker(
      context: context,
      initialDate: widget.dueDate,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(2100, 31, 12)) ?? widget.dueDate;
    
    setState(() {
      dateController.text = DateFormat('dd. MMMM yyyy', 'de_DE').format(widget.dueDate);
    });
  }
}