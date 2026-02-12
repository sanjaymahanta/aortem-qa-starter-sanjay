import 'dart:io';
import 'dart:convert'; // Added for jsonEncode if needed later
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

Middleware authMiddleware() {
  return (innerHandler) {
    return (Request req) async {
      final auth = req.headers['authorization'] ?? req.headers['Authorization'];
      
      // Simple path check for healthz
      if (req.url.path == 'healthz' || req.requestedUri.path.endsWith('/healthz')) {
        return innerHandler(req);
      }
      
      // Secret path check with Bearer token validation
      if (req.url.path == 'v1/secret' || req.requestedUri.path.endsWith('/v1/secret')) {
        if (auth == null || !auth.startsWith('Bearer ')) {
          return Response(401, 
            body: jsonEncode({"error": "missing_or_invalid_token"}), 
            headers: {'content-type': 'application/json'});
        }
        
        final token = auth.substring('Bearer '.length);
        if (token.isEmpty) {
          return Response(403, 
            body: jsonEncode({"error": "forbidden"}), 
            headers: {'content-type': 'application/json'});
        }
        
        // Context mein user data attach karna for the handler
        final updated = req.change(context: {'uid': 'demo-user'});
        return innerHandler(updated);
      }
      
      return innerHandler(req);
    };
  };
}

// Underscores removed to make these functions Public
Response healthz(Request _) => 
    Response.ok('{"status":"ok"}', headers: {'content-type': 'application/json'});

Response secret(Request req) {
  final uid = req.context['uid'] ?? 'unknown';
  return Response.ok('{"ok": true, "uid": "$uid"}', headers: {'content-type': 'application/json'});
}

void main(List<String> args) async {
  final app = Router()
    ..get('/healthz', healthz) // Pointing to public healthz
    ..get('/v1/secret', secret); // Pointing to public secret

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(authMiddleware())
      .addHandler(app);

  // Default port 8081 or from environment
  final port = int.parse(Platform.environment['PORT'] ?? '8081');
  final server = await serve(handler, InternetAddress.anyIPv4, port);
  
  print('Backend listening on port ${server.port}');
}