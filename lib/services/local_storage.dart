import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class LocalStorage {
  static const String keyNotes = 'notes';

  static Future<List<Note>> getNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(keyNotes);
    if (data == null) return [];
    List list = json.decode(data);
    return list.map((e) => Note.fromMap(e)).toList();
  }

  static Future saveNotes(List<Note> notes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      keyNotes,
      json.encode(notes.map((e) => e.toMap()).toList()),
    );
  }
}
