import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/local_storage.dart';
import 'note_form_page.dart';
import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key}); // boleh const, TIDAK WAJIB

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  void loadNotes() async {
    notes = await LocalStorage.getNotes();
    setState(() {});
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F6),

      appBar: AppBar(
        title: const Text("Daily Notes 💗"),
        backgroundColor: const Color(0xFFF48FB1),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF06292),
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NoteFormPage()),
          );
          loadNotes();
        },
      ),

      body: notes.isEmpty
          ? const Center(
              child: Text(
                "Belum ada catatan 🌸\nTambah catatan pertamamu!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      notes[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(notes[index].date),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.pink),
                      onPressed: () {
                        setState(() {
                          notes.removeAt(index);
                        });
                        LocalStorage.saveNotes(notes);
                      },
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NoteFormPage(
                            note: notes[index],
                            index: index,
                          ),
                        ),
                      );
                      loadNotes();
                    },
                  ),
                );
              },
            ),
    );
  }
}
