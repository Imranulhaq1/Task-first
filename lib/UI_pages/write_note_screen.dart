import 'package:flutter/material.dart';
import 'package:note_app_task/provider/show_note_pro.dart';
import 'package:provider/provider.dart';

class WriteNoteScreen extends StatelessWidget {
  const WriteNoteScreen({super.key, int? noteId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShowNotePro>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.teal,
        elevation: 1,
        title: const Text(
          'Write Note',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: provider.titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                  hintMaxLines: 1,
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
                  provider.publishNote(context);
                },
                child: const Text(
                  "Publish",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
