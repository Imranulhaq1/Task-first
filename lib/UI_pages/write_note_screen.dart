import 'package:flutter/material.dart';
import 'package:note_app_task/provider/show_note_pro.dart';
import 'package:provider/provider.dart';

class WriteNoteScreen extends StatelessWidget {
  final int? noteId;

  const WriteNoteScreen({super.key, this.noteId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShowNotePro>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(noteId == null ? 'Write Note' : 'Update Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: provider.titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: provider.descriptionController,
                maxLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  fixedSize: const Size(410, 48),
                ),
                onPressed: () {
                  if (noteId == null) {
                    provider.publishNote(context);
                  } else {
                    provider.updateNoted(context, noteId!);
                  }
                },
                child: Text(
                  noteId == null ? "Publish" : "Update",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
