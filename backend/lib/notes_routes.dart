import 'package:notes_repo_core/classes/note_routing.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class NotesRoutes {
  late final NotesRouting routing;

  NotesRoutes(Connection conn) {
    routing = NotesRouting(conn, "notes");
  }

  void register(Router router) {
    //final routing = NotesRouting(conn, "content.notes");

    // GET /notes_app
    router.get('/notes_app/', _getAll);

    // GET /notes_app/<id>
    router.get('/notes_app/<id>/', _getById);

    // POST /notes_app
    router.post('/notes_app/', _create);

    // PUT /notes_app/<id>
    router.put('/notes_app/<id>/', _update);

    // DELETE /notes_app/<id>
    router.delete('/notes_app/<id>/', _delete);
  }

  /// returns all notes as a list of json with the keys "id", "title", "body", "created_at", "updated_at"
  Future<Response> _getAll(Request req) async {
    return routing.getAll(req);
  }

  /// return the note with the specific id as json with the keys "id", "title", "body", "created_at", "updated_at"
  /// returns badRequest('Invalid id') if the id is not an int
  /// returns jsonResponse({'status': 'not_found'}) if the id was not found
  Future<Response> _getById(Request req, String id) async {
    return routing.getById(req, id);
  }

  /// returns created note as json
  /// returns badRequest('Request not formatted correctly') if req could not be parsed or contained other keys than title and body
  Future<Response> _create(Request req) async {
    return routing.create(req);
  }

  /// returns the updated note as json
  /// returns badRequest('Invalid id') if the id is not an int
  /// returns jsonResponse({'status': 'null_update'}) if neither title nor body was given
  /// returns jsonResponse({'status': 'not_found'}) if the id was not found
  /// returns badRequest('Request not formatted correctly') if req could not be parsed or contained other keys than title and body
  Future<Response> _update(Request req, String id) async {
    return routing.update(req, id);
  }

  /// returns jsonResponse({'status': 'deleted'})
  /// returns badRequest('Invalid id') if the id is not an int
  /// returns jsonResponse({'status': 'not_found'}) if the id was not found
  Future<Response> _delete(Request req, String id) async {
    return routing.delete(req, id);
  }
}
