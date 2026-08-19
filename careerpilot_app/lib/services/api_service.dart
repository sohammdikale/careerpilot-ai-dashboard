import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/app_models.dart';

class ApiService {
  // Default URL: http://10.0.2.2:8000 for Android Emulator, http://localhost:8000 for web/desktop
  String baseUrl;

  ApiService({this.baseUrl = 'http://10.0.2.2:8000'});

  Future<bool> checkHealth() async {
    try {
      final uri = Uri.parse('$baseUrl/health');
      final res = await http.get(uri).timeout(const Duration(seconds: 3));
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  // --- Profile ---
  Future<UserProfile?> fetchProfile() async {
    try {
      final res = await http
          .get(Uri.parse('$baseUrl/api/profile'))
          .timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        return UserProfile.fromJson(jsonDecode(res.body));
      }
    } catch (_) {}
    return null;
  }

  Future<UserProfile?> updateProfile({
    required String name,
    required String title,
    required String targetRole,
    required String bio,
    required String location,
  }) async {
    try {
      final body = jsonEncode({
        'name': name,
        'title': title,
        'targetRole': targetRole,
        'bio': bio,
        'location': location,
      });
      final res = await http
          .put(
            Uri.parse('$baseUrl/api/profile'),
            headers: {'Content-Type': 'application/json'},
            body: body,
          )
          .timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        return UserProfile.fromJson(jsonDecode(res.body));
      }
    } catch (_) {}
    return null;
  }

  // --- Skills ---
  Future<List<SkillItem>?> fetchSkills() async {
    try {
      final res = await http
          .get(Uri.parse('$baseUrl/api/skills'))
          .timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        final List list = jsonDecode(res.body);
        return list.map((e) => SkillItem.fromJson(e)).toList();
      }
    } catch (_) {}
    return null;
  }

  Future<SkillItem?> addSkill({
    required String name,
    required String category,
    required double proficiency,
    required bool isTargetRequired,
  }) async {
    try {
      final body = jsonEncode({
        'name': name,
        'category': category,
        'proficiency': proficiency,
        'isTargetRequired': isTargetRequired,
      });
      final res = await http
          .post(
            Uri.parse('$baseUrl/api/skills'),
            headers: {'Content-Type': 'application/json'},
            body: body,
          )
          .timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        return SkillItem.fromJson(jsonDecode(res.body));
      }
    } catch (_) {}
    return null;
  }

  Future<SkillItem?> updateSkillProficiency(String id, double proficiency) async {
    try {
      final body = jsonEncode({'proficiency': proficiency});
      final res = await http
          .put(
            Uri.parse('$baseUrl/api/skills/$id'),
            headers: {'Content-Type': 'application/json'},
            body: body,
          )
          .timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        return SkillItem.fromJson(jsonDecode(res.body));
      }
    } catch (_) {}
    return null;
  }

  // --- Roadmap ---
  Future<List<RoadmapMilestone>?> fetchRoadmap() async {
    try {
      final res = await http
          .get(Uri.parse('$baseUrl/api/roadmap'))
          .timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        final List list = jsonDecode(res.body);
        return list.map((e) => RoadmapMilestone.fromJson(e)).toList();
      }
    } catch (_) {}
    return null;
  }

  Future<RoadmapMilestone?> toggleRoadmapMilestone(String milestoneId) async {
    try {
      final res = await http
          .post(Uri.parse('$baseUrl/api/roadmap/$milestoneId/toggle'))
          .timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        return RoadmapMilestone.fromJson(jsonDecode(res.body));
      }
    } catch (_) {}
    return null;
  }

  // --- Resume ---
  Future<ResumeAnalysis?> fetchResumeAnalysis() async {
    try {
      final res = await http
          .get(Uri.parse('$baseUrl/api/resume'))
          .timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        return ResumeAnalysis.fromJson(jsonDecode(res.body));
      }
    } catch (_) {}
    return null;
  }

  Future<ResumeAnalysis?> applyResumeSuggestion(String suggestionId) async {
    try {
      final res = await http
          .post(Uri.parse('$baseUrl/api/resume/apply-suggestion/$suggestionId'))
          .timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        return ResumeAnalysis.fromJson(jsonDecode(res.body));
      }
    } catch (_) {}
    return null;
  }

  // --- Projects ---
  Future<List<ProjectRecommendation>?> fetchProjects() async {
    try {
      final res = await http
          .get(Uri.parse('$baseUrl/api/projects'))
          .timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        final List list = jsonDecode(res.body);
        return list.map((e) => ProjectRecommendation.fromJson(e)).toList();
      }
    } catch (_) {}
    return null;
  }

  Future<ProjectRecommendation?> toggleSaveProject(String projectId) async {
    try {
      final res = await http
          .post(Uri.parse('$baseUrl/api/projects/$projectId/toggle-save'))
          .timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        return ProjectRecommendation.fromJson(jsonDecode(res.body));
      }
    } catch (_) {}
    return null;
  }

  // --- Mock Interview ---
  Future<List<MockInterviewSession>?> fetchInterviews() async {
    try {
      final res = await http
          .get(Uri.parse('$baseUrl/api/interviews'))
          .timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        final List list = jsonDecode(res.body);
        return list.map((e) => MockInterviewSession.fromJson(e)).toList();
      }
    } catch (_) {}
    return null;
  }

  Future<MockInterviewSession?> evaluateInterview({
    required String sessionId,
    required String transcript,
  }) async {
    try {
      final body = jsonEncode({
        'id': sessionId,
        'userTranscript': transcript,
      });
      final res = await http
          .post(
            Uri.parse('$baseUrl/api/interviews/evaluate'),
            headers: {'Content-Type': 'application/json'},
            body: body,
          )
          .timeout(const Duration(seconds: 5));
      if (res.statusCode == 200) {
        return MockInterviewSession.fromJson(jsonDecode(res.body));
      }
    } catch (_) {}
    return null;
  }

  // --- Analytics ---
  Future<List<ProgressMetric>?> fetchAnalytics() async {
    try {
      final res = await http
          .get(Uri.parse('$baseUrl/api/analytics'))
          .timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        final List list = jsonDecode(res.body);
        return list.map((e) => ProgressMetric.fromJson(e)).toList();
      }
    } catch (_) {}
    return null;
  }
}
