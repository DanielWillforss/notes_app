import 'package:app_core/util/exceptions.dart';
import 'package:app_core/util/general_util.dart';
import 'note_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class NotesRouting {
  late NoteRepository notesRepo;

  NotesRouting() {
    notesRepo = NoteRepository();
  }

  void register(Router router) {

    // GET /notes/
    router.get('/', getAll);

    // POST /notes/
    router.post('/', create);

    // PUT /notes/<id>/title/
    router.put('/<id>/title/', updateTitle);

    // PUT /notes/<id>/body/
    router.put('/<id>/body/', updateContent);

    // PUT /notes/<id>/parent/
    router.put('/<id>/parent/', updateParentId);

    // DELETE /notes/<id>/
    router.delete('/<id>/', delete);

  }

  /// returns all notes as a list of json with the keys "id", "title", "body", "parent_id", "created_at", "updated_at"
  Future<Response> getAll(Request req) async {
    return _allNotesResponse();
  }

  /// return the note with the specific id as json
  /// returns badRequest('Invalid id') if the id is not an int
  /// returns jsonResponse({'status': 'not_found'}) if the id was not found
  Future<Response> getById(Request req) async {
    final id = req.params['id'];
    final parsedId = parseId(id!);
    if (!parsedId.isOk) return parsedId.error!;

    try {
      final note = await notesRepo.findById(parsedId.value!);
      return jsonResponse(note.toJson());
    } on IdNotFoundException {
      return jsonResponse({'status': 'not_found'});
    }
  }

  /// creates new note with specific title
  /// returns all notes as a list of json
  /// returns badRequest('Request not formatted correctly') if req could not be parsed or contained other keys than title
  Future<Response> create(Request req) async {
    final payload = await decodeRequest(req, allowedKeys: {'title'});
    if (payload == null) {
      return Response.badRequest(body: 'Request not formatted correctly');
    }

    await notesRepo.insert(title: payload['title']);
    return _allNotesResponse();
  }

  /// returns all notes as a list of json
  /// returns badRequest('Invalid id') if the id is not an int
  /// returns badRequest(body: 'null_update') if title was not given
  /// returns badRequest(body: 'not_found') if the id was not found
  /// returns badRequest('Request not formatted correctly') if req could not be parsed or contained other keys than title
  Future<Response> updateTitle(Request req) {
    return _updateField(
      req,
      field: 'title',
      updater: (id, value) => notesRepo.updateTitle(id: id, title: value),
    );
  }

  /// returns all notes as a list of json
  /// returns badRequest('Invalid id') if the id is not an int
  /// returns badRequest(body: 'null_update') if body was not given
  /// returns badRequest(body: 'not_found') if the id was not found
  /// returns badRequest('Request not formatted correctly') if req could not be parsed or contained other keys than body
  Future<Response> updateContent(Request req) {
    return _updateField(
      req,
      field: 'body',
      updater: (id, value) => notesRepo.updateBody(id: id, body: value),
    );
  }

  /// returns all notes as a list of json
  /// returns badRequest('Invalid id') if the id is not an int
  /// returns badRequest(body: 'null_update') if parentId was not given
  /// returns badRequest(body: 'not_found') if the id was not found
  /// returns badRequest('Request not formatted correctly') if req could not be parsed or contained other keys than parentId
  Future<Response> updateParentId(Request req) {
    return _updateField(
      req,
      field: 'parentId',
      updater: (id, value) => notesRepo.updateParent(id: id, parentId: value),
    );
  }

  /// returns all notes as a list of json
  /// returns badRequest('Invalid id') if the id is not an int
  /// returns badRequest(body: 'not_found') if the id was not found
  Future<Response> delete(Request req) async {
    final id = req.params['id'];
    final parsedId = parseId(id!);
    if (!parsedId.isOk) return parsedId.error!;

    try {
      await notesRepo.delete(parsedId.value!);
      return _allNotesResponse();
    } on IdNotFoundException {
      return Response.badRequest(body: 'not_found');
    }
  }

  Future<Response> _allNotesResponse() async {
    final notes = await notesRepo.findAll();
    return jsonResponse(notes.map((n) => n.toJson()).toList());
  }

  Future<Response> _updateField(
    Request req, {
    required String field,
    required Future<void> Function(int id, dynamic value) updater,
  }) async {
    final parsedId = parseId(req.params['id']!);
    if (!parsedId.isOk) return parsedId.error!;

    final payload = await decodeRequest(req, allowedKeys: {field});
    if (payload == null) {
      return Response.badRequest(body: 'Request not formatted correctly');
    }

    final value = payload[field];
    // if (value == null) {
    //   return Response.badRequest(body: 'null_update');
    // }

    try {
      await updater(parsedId.value!, value);
      return _allNotesResponse();
    } on IdNotFoundException {
      return Response.badRequest(body: 'not_found');
    }
  }
}
