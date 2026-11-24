import 'package:flutter_test/flutter_test.dart';
import 'package:student_dashboard/main.dart';

void main() {
  testWidgets('Student Dashboard HOL smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentDashboardApp());

    expect(find.text('Student Dashboard'), findsOneWidget);
    expect(find.text('Hello, Student!'), findsOneWidget);
    expect(find.text('Farrel Aryasatya Raharjo'), findsOneWidget);
    expect(find.text('Interactive Counter'), findsOneWidget);
    expect(find.text('Learning Menu'), findsOneWidget);
    expect(find.text('Grades'), findsOneWidget);
  });
}
