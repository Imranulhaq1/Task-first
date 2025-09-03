import 'package:flutter/material.dart';
import 'package:note_app_task/UI_pages/add_note_Screen.dart';
import 'package:note_app_task/provider/show_note_pro.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => WriteNoteProvider()),
        ChangeNotifierProvider(create: (_) => ShowNotePro()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
