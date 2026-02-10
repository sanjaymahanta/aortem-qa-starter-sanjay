import 'package:flutter_test/flutter_test.dart';
import 'package:aortem_qa_frontend/main.dart' as app;

void main() {
  testWidgets('App renders title', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('Aortem QA Frontend (Flutter Web)'), findsOneWidget);
  });
}