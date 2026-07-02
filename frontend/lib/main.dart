import 'package:app_core_widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/notes_page.dart';

void main() {
  runApp(MyApp());
}

class GlobalConstants {
  //static const String baseUrl = 'https://danielwillforss.site/notes_app';
  //static const String baseUrl = 'http://192.168.0.130/notes_app';
  static const String baseUrl = 'http://localhost:5000';
  static const String version = '1.1.0';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: RedTheme.appTheme,
      //home: BubblePage(),
      home: NotesPage(),

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }
}

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Notes')),
//       body: NotesPage(),
//     );
//   }
// }
