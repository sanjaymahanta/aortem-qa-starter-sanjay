import 'package:test/test.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';
import '../bin/server.dart' as srv;

void main() {
  test('healthz returns ok', () async {
    // FIXED: srv._healthz ko srv.healthz kar diya
    final app = Router()..get('/healthz', srv.healthz); 
    final res = await app.call(Request('GET', Uri.parse('http://localhost/healthz')));
    expect(res.statusCode, 200);
    final body = await res.readAsString();
    expect(json.decode(body)['status'], 'ok');
  });

  test('secret requires token', () async {
    // FIXED: srv._secret ko srv.secret kar diya
    final app = Router()..get('/v1/secret', srv.secret);
    final handler = const Pipeline().addMiddleware(srv.authMiddleware()).addHandler(app);
    final res = await handler(Request('GET', Uri.parse('http://localhost/v1/secret')));
    expect(res.statusCode, 401);
  });
}