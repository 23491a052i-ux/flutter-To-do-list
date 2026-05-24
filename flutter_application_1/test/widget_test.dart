import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text("✨ My To-Do"), findsOneWidget);
  });
}
