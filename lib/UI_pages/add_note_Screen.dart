import 'package:flutter/material.dart';
import 'package:note_app_task/UI_pages/sinup_page.dart';
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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.teal,
        elevation: 1,
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: Icon(
              Icons.more_vert,
              size: 30,
              color: Colors.white,
            ),
            offset: Offset(0, 35),
            onSelected: (value) {
              if (value == 1) {
                print("Share tapped");
              } else if (value == 2) {
                print("Logout tapped");
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Text("Share"),
                    SizedBox(width: 12),
                    Icon(Icons.share, color: Colors.black),
                  ],
                ),
              ),
              PopupMenuItem(
                  value: 4,
                  child: Row(
                    children: [
                      Text("Logout"),
                      SizedBox(
                        width: 0,
                      ),
                      IconButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SinupPage()));
                          },
                          icon: Icon(Icons.logout, color: Colors.black)),
                    ],
                  )),
            ],
          ),
        ],
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
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0)
                      .copyWith(bottom: 12),
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
                      // overflow: TextOverflow.ellipsis,
                    ),
                    trailing:
                        // Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        //  mainAxisSize: MainAxisSize.min,
                        // children: [
                        // IconButton(
                        //   onPressed: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (_) => WriteNoteScreen()));
                        //     context.read<ShowNotePro>().updateNoted(context,
                        //         note.id!, note.title, note.description);
                        //     pro.loadNotes();
                        //   },
                        //   icon: const Icon(Icons.edit, color: Colors.green),
                        // ),
                        IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        context.read<ShowNotePro>().deleteNote(note.id!);
                        await pro.loadNotes();
                      },
                    ),
                    // ],
                  ),
                  // ),
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
