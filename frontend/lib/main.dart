import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const QAApp());
}

class QAApp extends StatefulWidget {
  const QAApp({super.key});
  @override
  State<QAApp> createState() => _QAAppState();
}

class _QAAppState extends State<QAApp> {
  final _emailCtl = TextEditingController(text: "test@example.com");
  final _passwordCtl = TextEditingController(text: "password123");
  String? _token;
  String _log = "";
  String apiBase = const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8081');

  Future<void> _signInMock() async {
    // In real assignment, candidate can swap with emulator SDK auth.
    setState(() {
      _token = base64Url.encode(utf8.encode('uid:demo-user'));
      _log = "Signed in (mock). Token set.";
    });
  }

  Future<void> _callSecret() async {
    final uri = Uri.parse("$apiBase/v1/secret");
    final res = await http.get(uri, headers: {
      if (_token != null) "Authorization": "Bearer $_token",
    });
    setState(() {
      _log = "GET /v1/secret -> ${res.statusCode}\n${res.body}";
    });
  }

  Future<void> _healthz() async {
    final uri = Uri.parse("$apiBase/healthz");
    final res = await http.get(uri);
    setState(() {
      _log = "GET /healthz -> ${res.statusCode}\n${res.body}";
    });
  }

  void _signOut() {
    setState(() {
      _token = null;
      _log = "Signed out.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Aortem QA Frontend (Flutter Web)')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Login (mock) — replace with emulator auth if desired."),
              TextField(controller: _emailCtl, decoration: const InputDecoration(labelText: "Email")),
              TextField(controller: _passwordCtl, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
              const SizedBox(height: 8),
              Wrap(spacing: 8, children: [
                ElevatedButton(onPressed: _signInMock, child: const Text("Sign In (mock)")),
                ElevatedButton(onPressed: _signOut, child: const Text("Sign Out")),
              ]),
              const Divider(),
              Wrap(spacing: 8, children: [
                ElevatedButton(onPressed: _healthz, child: const Text("Call /healthz")),
                ElevatedButton(onPressed: _callSecret, child: const Text("Call /v1/secret (protected)")),
              ]),
              const SizedBox(height: 12),
              Expanded(child: SingleChildScrollView(child: Text(_log))),
            ],
          ),
        ),
      ),
    );
  }
}