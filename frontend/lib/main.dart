import 'package:flutter/material.dart';
import 'package:notes_app/pages/notes_page.dart';

void main() {
  runApp(MyApp());
}

class GlobalConstants {
  static const String baseUrl = 'https://danielwillforss.site/notes_app/';
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
      home: MainPage(),

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
  int _selectedIndex = 0;

  final List<Widget> _pages = [NotesPage()];

  final List<String> _titles = ['Notes'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      body: _pages[_selectedIndex],
      //bottomNavigationBar: BottomNavigationBar(
      //  currentIndex: _selectedIndex,
      //  onTap: _onItemTapped,
      //  items: const [
      //    BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
      //  ],
      //),
    );
  }
}
