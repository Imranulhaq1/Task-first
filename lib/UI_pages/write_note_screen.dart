import 'package:flutter/material.dart';
import 'package:note_app_task/provider/show_note_pro.dart';
import 'package:provider/provider.dart';

class WriteNoteScreen extends StatelessWidget {
  const WriteNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShowNotePro>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Write Notes",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
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
                  backgroundColor: Colors.blue,
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
