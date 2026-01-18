import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/local_storage.dart';

class NoteFormPage extends StatefulWidget {
  final Note? note;
  final int? index;

  NoteFormPage({this.note, this.index});

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
  }

  void save() async {
    List<Note> notes = await LocalStorage.getNotes();
    final date = DateTime.now().toString().split(' ')[0];

    if (widget.index != null) {
      notes[widget.index!] = Note(
        title: titleController.text,
        content: contentController.text,
        date: date,
      );
    } else {
      notes.add(Note(
        title: titleController.text,
        content: contentController.text,
        date: date,
      ));
    }

    await LocalStorage.saveNotes(notes);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Catatan")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Judul"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: "Isi"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: save,
              child: const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
