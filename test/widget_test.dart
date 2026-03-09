import 'package:flutter_test/flutter_test.dart';
import 'package:taskati/taskati.dart';

void main() {
  testWidgets('shows splash then navigates to auth', (WidgetTester tester) async {
    await tester.pumpWidget(const Taskati());
    expect(find.text('Taskati'), findsOneWidget);
    expect(find.text("IT's Time to get organized!"), findsOneWidget);
    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();
    expect(find.text('Submit'), findsOneWidget);
  });
}
