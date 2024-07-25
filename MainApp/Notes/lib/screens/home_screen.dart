import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/screens/note_screen.dart';
import 'package:notes_app/providers/note_provider.dart';
import 'package:notes_app/models/note.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          return ListView.builder(
            itemCount: noteProvider.notes.length,
            itemBuilder: (context, index) {
              final note = noteProvider.notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.content),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteScreen(note: note),
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    noteProvider.deleteNote(note.id!);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NoteScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
