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
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ShowNotePro>().loadNotes());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ShowNotePro>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search notes...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: provider.searchNotes,
              )
            : const Text(
                'Notes',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 30, color: Colors.white),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  provider.searchNotes("");
                }
              });
            },
          ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert, size: 30, color: Colors.white),
            offset: const Offset(0, 35),
            onSelected: (value) {
              if (value == 1) {
                print("Share tapped");
              } else if (value == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SinupPage()),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Text("Share"),
                    SizedBox(width: 12),
                    Icon(Icons.share, color: Colors.black),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Text("Logout"),
                    SizedBox(width: 12),
                    Icon(Icons.logout, color: Colors.black),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: provider.filteredNotes.isEmpty
          ? const Center(
              child: Text(
                "No notes yet",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: provider.filteredNotes.length,
              itemBuilder: (context, index) {
                final note = provider.filteredNotes[index];
                return Card(
                  elevation: 4,
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 📝 Title + Description
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                note.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                note.description,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<ShowNotePro>().fillControllers(
                                    note.title, note.description);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        WriteNoteScreen(noteId: note.id),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit, color: Colors.green),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                context
                                    .read<ShowNotePro>()
                                    .deleteNote(note.id!);
                              },
                            ),
                          ],
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
          context.read<ShowNotePro>().clearFields();
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
