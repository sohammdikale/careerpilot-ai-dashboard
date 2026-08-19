import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state.dart';
import 'theme/app_theme.dart';
import 'widgets/main_shell.dart';
import 'screens/dashboard_screen.dart';
import 'screens/roadmap_screen.dart';
import 'screens/skill_gap_analysis_screen.dart';
import 'screens/skills_screen.dart';
import 'screens/resume_intelligence_screen.dart';
import 'screens/project_recommendations_screen.dart';
import 'screens/ai_mock_interview_screen.dart';
import 'screens/progress_analytics_screen.dart';
import 'screens/my_profile_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const CareerPilotApp(),
    ),
  );
}

class CareerPilotApp extends StatelessWidget {
  const CareerPilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return MaterialApp(
      title: 'CareerPilot AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MainShell(
        child: _buildScreen(appState.currentScreenIndex),
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const RoadmapScreen();
      case 2:
        return const SkillGapAnalysisScreen();
      case 3:
        return const SkillsScreen();
      case 4:
        return const ResumeIntelligenceScreen();
      case 5:
        return const ProjectRecommendationsScreen();
      case 6:
        return const AiMockInterviewScreen();
      case 7:
        return const ProgressAnalyticsScreen();
      case 8:
        return const MyProfileScreen();
      case 9:
        return const SettingsScreen();
      default:
        return const DashboardScreen();
    }
  }
}
