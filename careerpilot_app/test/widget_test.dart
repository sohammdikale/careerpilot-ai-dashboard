import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:careerpilot_app/main.dart';
import 'package:careerpilot_app/providers/app_state.dart';

void main() {
  final screenNames = [
    'Dashboard',
    'Roadmap',
    'Skill Gap Analysis',
    'Skills',
    'Resume Intelligence',
    'Project Recommendations',
    'AI Mock Interview',
    'Progress Analytics',
    'My Profile',
    'Settings',
  ];

  for (int i = 0; i < screenNames.length; i++) {
    final index = i;
    final name = screenNames[i];

    testWidgets('Desktop Screen Audit: $name (Index $index)', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final appState = AppState()..setScreenIndex(index);

      await tester.pumpWidget(
        ChangeNotifierProvider<AppState>.value(
          value: appState,
          child: const CareerPilotApp(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
    });

    testWidgets('Mobile Screen Audit: $name (Index $index)', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final appState = AppState()..setScreenIndex(index);

      await tester.pumpWidget(
        ChangeNotifierProvider<AppState>.value(
          value: appState,
          child: const CareerPilotApp(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
    });
  }
}
