// import 'package:flutter/material.dart';
// import 'package:note_app_task/database/database.dart';
// import 'package:note_app_task/modle/node.dart';

// class WriteNoteProvider extends ChangeNotifier {
//   List<Notemdl> notes = [];

//   Future<void> loadNotes() async {
//     notes = await NotesDatabase.instance.fetchNotes();
//     notifyListeners();
//   }

//   Future<void> insertNote(Notemdl note) async {
//     await NotesDatabase.instance.insertNote(note.toMap());
//     await loadNotes();
//     notifyListeners();
//   }

//   Future<void> deleteNote(int id) async {
//     await NotesDatabase.instance.deleteNote(id);
//     await loadNotes();
//     notifyListeners();
//   }

//   Future<void> updateNoted(int id, String title, String description) async {
//     final updatedNote = Notemdl(id: id, title: title, description: description);
//     await NotesDatabase.instance.updateNote(updatedNote.toMap());
//     await loadNotes();
//     notifyListeners();
//   }
// }
