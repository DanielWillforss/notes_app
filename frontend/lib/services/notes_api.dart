import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notes_app/main.dart';
import 'package:notes_app/note.dart';

class NotesApi {
  static const String baseUrl = GlobalConstants.baseUrl;

  /// GET /notes
  static Future<List<Note>> getNotes() async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load notes');
    }

    final List data = jsonDecode(response.body);
    print(data);
    return data.map((e) => Note.fromJson(e)).toList();
  }

  /// POST /notes
  static Future<Note> createNote(String title, String body) async {
    final response = await http.post(
      Uri.parse('$baseUrl'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'body': body}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create note');
    }

    final Note note = Note.fromJson(jsonDecode(response.body));
    return note;
  }

  /// PUT /notes/{id}
  static Future<Note> updateNote(int id, String title, String body) async {
    final response = await http.put(
      Uri.parse('$baseUrl$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'body': body}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update note');
    }

    final Note note = Note.fromJson(jsonDecode(response.body));
    return note;
  }

  /// DELETE /notes/{id}
  static Future<void> deleteNote(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete note');
    }
  }
}
