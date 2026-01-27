import 'package:flutter/material.dart';
import 'package:notes_repo_widget/note_widget_package.dart';

void main() {
  //NotesApi.baseUrl = 'https://danielwillforss.site/notes_app';
  NotesApi.baseUrl = 'http://127.0.0.1:5000/notes_app/';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        // Main theme colors
        brightness: Brightness.dark,
        primaryColor: Colors.red[700],
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[800],
          foregroundColor: Colors.grey[200],
          elevation: 4,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[200],
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[200],
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black54,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.red,
          foregroundColor: Colors.grey[200],
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Notes')),
        body: NotesPage(),
      ),

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: NotesPage(),
    );
  }
}
