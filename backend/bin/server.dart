import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

Middleware authMiddleware() {
  return (innerHandler) {
    return (Request req) async {
      final auth = req.headers['authorization'] ?? req.headers['Authorization'];
      if (req.requestedUri.path == 'healthz' || req.url.path == 'healthz') {
        return innerHandler(req);
      }
      if (req.requestedUri.path == 'v1/secret' || req.url.path == 'v1/secret') {
        if (auth == null || !auth.startsWith('Bearer ')) {
          return Response(401, body: '{"error":"missing_or_invalid_token"}', headers: {'content-type':'application/json'});
        }
        final token = auth.substring('Bearer '.length);
        // Mock validation: accept any non-empty token; decode mock uid if base64 'uid:...'
        if (token.isEmpty) {
          return Response(403, body: '{"error":"forbidden"}', headers: {'content-type':'application/json'});
        }
        // Attach a simple uid in context for handler demo
        final updated = req.change(context: {'uid': 'demo-user'});
        return innerHandler(updated);
      }
      return innerHandler(req);
    };
  };
}

Response _healthz(Request _) => Response.ok('{"status":"ok"}', headers: {'content-type': 'application/json'});

Response _secret(Request req) {
  final uid = req.context['uid'] ?? 'unknown';
  return Response.ok('{"ok": true, "uid": "$uid"}', headers: {'content-type': 'application/json'});
}

void main(List<String> args) async {
  final app = Router()
    ..get('/healthz', _healthz)
    ..get('/v1/secret', _secret);

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(authMiddleware())
      .addHandler(app);

  final port = int.parse(Platform.environment['PORT'] ?? '8081');
  final server = await serve(handler, InternetAddress.anyIPv4, port);
  print('Backend listening on port ${server.port}');
}