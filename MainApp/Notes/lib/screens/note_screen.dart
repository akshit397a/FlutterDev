import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/providers/note_provider.dart';
import 'package:notes_app/models/note.dart';

class NoteScreen extends StatefulWidget {
  final Note? note;

  const NoteScreen({super.key, this.note});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final title = _titleController.text;
              final content = _contentController.text;

              if (widget.note == null) {
                final newNote = Note(
                  title: title,
                  content: content,
                );
                Provider.of<NoteProvider>(context, listen: false).addNote(newNote);
              } else {
                final updatedNote = Note(
                  id: widget.note!.id,
                  title: title,
                  content: content,
                );
                Provider.of<NoteProvider>(context, listen: false).updateNote(updatedNote);
              }

              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }
}
