import 'package:flutter/material.dart';

class EditTodoDialog extends StatefulWidget {
  final Function(String, String) onTodoEdited;
  final String editButtonText;
  String title, description;
  
  EditTodoDialog({
    Key? key,
    required this.onTodoEdited,
    required this.editButtonText,
    this.title = '',
    this.description = '',
  }) : super(key: key);

  @override
  State<EditTodoDialog> createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {

  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      title: const Text('Neues Todo hinzufügen'),
      content: Column(
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
            widget.onTodoEdited(widget.title, widget.description);
            Navigator.of(context).pop();
          },
          child: Text(widget.editButtonText),
        ),
      ],
    );
  }
}