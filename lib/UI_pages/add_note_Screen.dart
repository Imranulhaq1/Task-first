import 'package:flutter/material.dart';
import 'package:note_app_task/UI_pages/write_note_screen.dart';
import 'package:note_app_task/provider/show_note_pro.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ShowNotePro>().loadNotes());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ShowNotePro>();
    final pro = context.read<ShowNotePro>();
    pro.loadNotes();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Notes",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: provider.notes.isEmpty
          ? const Center(
              child: Text(
                "No notes yet",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: provider.notes.length,
              itemBuilder: (context, index) {
                final note = provider.notes[index];
                return Card(
                  elevation: 4,
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      note.description,
                      style: const TextStyle(color: Colors.blue),
                      //maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => WriteNoteScreen()));
                            // context.read<ShowNotePro>().updateNoted(
                            //     note.id!, note.title, note.description);
                            // pro.loadNotes();
                          },
                          icon: const Icon(Icons.edit, color: Colors.green),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            context.read<ShowNotePro>().deleteNote(note.id!);
                            //await pro.loadNotes();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WriteNoteScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
