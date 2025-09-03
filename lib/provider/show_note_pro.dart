import 'package:flutter/material.dart';
import 'package:note_app_task/database/database.dart';
import 'package:note_app_task/modle/node.dart';
import 'package:provider/provider.dart';

class ShowNotePro with ChangeNotifier {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final List<Notemdl> _notes = [];
  List<Notemdl> get notes => _notes;
  bool _validateInput(String title, String description) {
    return title.isNotEmpty && description.isNotEmpty;
  }

  Future<void> publishNote(BuildContext context) async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    if (!_validateInput(title, description)) {
      await showdialogg(
          context, "Error", "Title and Description cannot be empty");
      return;
    }
    final success = await _saveNoteToDatabase(title, description);
    if (success) {
      _clearFields();
      await loadNotes();
      await showdialogg(context, "Success", "Note added successfully");
    } else {
      await showdialogg(context, "Error", "Failed to save note");
    }
  }

  Future<bool> _saveNoteToDatabase(String title, String description) async {
    try {
      final newNote = Notemdl(title: title, description: description);
      await NotesDatabase.instance.insertNote(newNote.toMap());
      return true;
    } catch (e) {
      debugPrint("Error saving note: $e");
      return false;
    }
  }

  void _clearFields() {
    titleController.clear();
    descriptionController.clear();
    notifyListeners();
  }

  Future<void> loadNotes() async {
    try {
      final notesList = await NotesDatabase.instance.fetchNotes();
      _notes.clear();
      _notes.addAll(notesList);
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading notes: $e");
    }
  }

  Future<void> updateNoted(int id, String title, String description) async {
    // final title = titleController.text;
    // final description = descriptionController.text;
    final updatedNote = Notemdl(id: id, title: title, description: description);
    await NotesDatabase.instance.updateNote(updatedNote.toMap());
    await loadNotes();
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    try {
      await NotesDatabase.instance.deleteNote(id);
      _notes.removeWhere((note) => note.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint("Error deleting note: $e");
    }
  }

  Future<void> showdialogg(
      BuildContext context, String title, String description) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    final provider =
                        Provider.of<ShowNotePro>(context, listen: false);
                    await provider.loadNotes();
                  },
                  child: const Text('Show Notes'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
