import 'package:notes_app/01_routing/notes_routes.dart';
import 'package:notes_app/02_repositories/note_repository.dart';
import 'package:notes_app/database_connection.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

Future<void> main() async {
  final conn = await DatabaseConnection.get();
  final router = Router();

  // Register route groups
  NotesRoutes(NoteRepository(), conn).register(router);

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router.call);

  final server = await io.serve(handler, '127.0.0.1', 5000);
  print('Server running on http://${server.address.host}:${server.port}');
}
