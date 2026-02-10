import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_static/shelf_static.dart';

Future<void> main(List<String> args) async {
  final handler = Cascade()
      .add(createStaticHandler('public', defaultDocument: 'index.html'))
      .add((_) => Response.notFound('Not Found'))
      .handler;

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, InternetAddress.anyIPv4, port);
  print('Frontend server listening on port ${server.port}');
}