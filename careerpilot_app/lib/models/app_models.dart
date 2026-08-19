class UserProfile {
  String name;
  String title;
  String targetRole;
  String bio;
  String email;
  String location;
  int readinessScore;
  String avatarUrl;
  int completedMilestones;
  int totalMilestones;

  UserProfile({
    required this.name,
    required this.title,
    required this.targetRole,
    required this.bio,
    required this.email,
    required this.location,
    required this.readinessScore,
    required this.avatarUrl,
    required this.completedMilestones,
    required this.totalMilestones,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      targetRole: json['targetRole'] ?? '',
      bio: json['bio'] ?? '',
      email: json['email'] ?? '',
      location: json['location'] ?? '',
      readinessScore: (json['readinessScore'] as num?)?.toInt() ?? 0,
      avatarUrl: json['avatarUrl'] ?? '',
      completedMilestones: (json['completedMilestones'] as num?)?.toInt() ?? 0,
      totalMilestones: (json['totalMilestones'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'targetRole': targetRole,
      'bio': bio,
      'email': email,
      'location': location,
      'readinessScore': readinessScore,
      'avatarUrl': avatarUrl,
      'completedMilestones': completedMilestones,
      'totalMilestones': totalMilestones,
    };
  }
}

class SkillItem {
  final String id;
  final String name;
  final String category; // 'AI/ML', 'Backend', 'Frontend', 'Cloud', 'Data'
  double proficiency; // 0.0 - 1.0
  String status; // 'Mastered', 'In Progress', 'Skill Gap'
  bool isTargetRequired;

  SkillItem({
    required this.id,
    required this.name,
    required this.category,
    required this.proficiency,
    required this.status,
    this.isTargetRequired = false,
  });

  factory SkillItem.fromJson(Map<String, dynamic> json) {
    return SkillItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      proficiency: (json['proficiency'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'In Progress',
      isTargetRequired: json['isTargetRequired'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'proficiency': proficiency,
      'status': status,
      'isTargetRequired': isTargetRequired,
    };
  }
}

class RoadmapMilestone {
  final String id;
  final String title;
  final String phase; // 'Phase 1: Foundations', 'Phase 2: Core ML', 'Phase 3: Advanced'
  final String description;
  bool isCompleted;
  final String duration;
  final List<String> skillsCovered;

  RoadmapMilestone({
    required this.id,
    required this.title,
    required this.phase,
    required this.description,
    required this.isCompleted,
    required this.duration,
    required this.skillsCovered,
  });

  factory RoadmapMilestone.fromJson(Map<String, dynamic> json) {
    return RoadmapMilestone(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      phase: json['phase'] ?? '',
      description: json['description'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      duration: json['duration'] ?? '',
      skillsCovered: List<String>.from(json['skillsCovered'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'phase': phase,
      'description': description,
      'isCompleted': isCompleted,
      'duration': duration,
      'skillsCovered': skillsCovered,
    };
  }
}

class ResumeSuggestion {
  final String id;
  final String section; // 'Impact', 'Keywords', 'Formatting', 'Skills'
  final String title;
  final String description;
  final String impactLevel; // 'High', 'Medium', 'Low'
  bool isApplied;

  ResumeSuggestion({
    required this.id,
    required this.section,
    required this.title,
    required this.description,
    required this.impactLevel,
    this.isApplied = false,
  });

  factory ResumeSuggestion.fromJson(Map<String, dynamic> json) {
    return ResumeSuggestion(
      id: json['id'] ?? '',
      section: json['section'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      impactLevel: json['impactLevel'] ?? 'Medium',
      isApplied: json['isApplied'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'section': section,
      'title': title,
      'description': description,
      'impactLevel': impactLevel,
      'isApplied': isApplied,
    };
  }
}

class ResumeAnalysis {
  int overallAtsScore;
  int impactScore;
  int keywordMatchScore;
  int formatScore;
  int structureScore;
  List<ResumeSuggestion> suggestions;

  ResumeAnalysis({
    required this.overallAtsScore,
    required this.impactScore,
    required this.keywordMatchScore,
    required this.formatScore,
    required this.structureScore,
    required this.suggestions,
  });

  factory ResumeAnalysis.fromJson(Map<String, dynamic> json) {
    var rawList = json['suggestions'] as List? ?? [];
    List<ResumeSuggestion> parsedSuggestions =
        rawList.map((i) => ResumeSuggestion.fromJson(i)).toList();

    return ResumeAnalysis(
      overallAtsScore: (json['overallAtsScore'] as num?)?.toInt() ?? 0,
      impactScore: (json['impactScore'] as num?)?.toInt() ?? 0,
      keywordMatchScore: (json['keywordMatchScore'] as num?)?.toInt() ?? 0,
      formatScore: (json['formatScore'] as num?)?.toInt() ?? 0,
      structureScore: (json['structureScore'] as num?)?.toInt() ?? 0,
      suggestions: parsedSuggestions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'overallAtsScore': overallAtsScore,
      'impactScore': impactScore,
      'keywordMatchScore': keywordMatchScore,
      'formatScore': formatScore,
      'structureScore': structureScore,
      'suggestions': suggestions.map((s) => s.toJson()).toList(),
    };
  }
}

class ProjectRecommendation {
  final String id;
  final String title;
  final String domain;
  final String difficulty; // 'Beginner', 'Intermediate', 'Advanced'
  final String description;
  final List<String> tags;
  final int matchPercentage;
  final String estimatedDuration;
  bool isSaved;
  bool isStarted;

  ProjectRecommendation({
    required this.id,
    required this.title,
    required this.domain,
    required this.difficulty,
    required this.description,
    required this.tags,
    required this.matchPercentage,
    required this.estimatedDuration,
    this.isSaved = false,
    this.isStarted = false,
  });

  factory ProjectRecommendation.fromJson(Map<String, dynamic> json) {
    return ProjectRecommendation(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      domain: json['domain'] ?? '',
      difficulty: json['difficulty'] ?? 'Intermediate',
      description: json['description'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      matchPercentage: (json['matchPercentage'] as num?)?.toInt() ?? 0,
      estimatedDuration: json['estimatedDuration'] ?? '',
      isSaved: json['isSaved'] ?? false,
      isStarted: json['isStarted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'domain': domain,
      'difficulty': difficulty,
      'description': description,
      'tags': tags,
      'matchPercentage': matchPercentage,
      'estimatedDuration': estimatedDuration,
      'isSaved': isSaved,
      'isStarted': isStarted,
    };
  }
}

class MockInterviewSession {
  final String id;
  final String question;
  final String category; // 'Technical ML', 'System Design', 'Behavioral'
  final String difficulty;
  String? userAudioPath;
  String? userTranscript;
  int? overallScore;
  int? clarityScore;
  int? technicalDepthScore;
  int? confidenceScore;
  String? aiFeedback;

  MockInterviewSession({
    required this.id,
    required this.question,
    required this.category,
    required this.difficulty,
    this.userAudioPath,
    this.userTranscript,
    this.overallScore,
    this.clarityScore,
    this.technicalDepthScore,
    this.confidenceScore,
    this.aiFeedback,
  });

  factory MockInterviewSession.fromJson(Map<String, dynamic> json) {
    return MockInterviewSession(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      category: json['category'] ?? '',
      difficulty: json['difficulty'] ?? '',
      userAudioPath: json['userAudioPath'],
      userTranscript: json['userTranscript'],
      overallScore: (json['overallScore'] as num?)?.toInt(),
      clarityScore: (json['clarityScore'] as num?)?.toInt(),
      technicalDepthScore: (json['technicalDepthScore'] as num?)?.toInt(),
      confidenceScore: (json['confidenceScore'] as num?)?.toInt(),
      aiFeedback: json['aiFeedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'category': category,
      'difficulty': difficulty,
      'userAudioPath': userAudioPath,
      'userTranscript': userTranscript,
      'overallScore': overallScore,
      'clarityScore': clarityScore,
      'technicalDepthScore': technicalDepthScore,
      'confidenceScore': confidenceScore,
      'aiFeedback': aiFeedback,
    };
  }
}

class ProgressMetric {
  final String day;
  final double skillScore;
  final double interviewScore;
  final double readinessScore;

  ProgressMetric({
    required this.day,
    required this.skillScore,
    required this.interviewScore,
    required this.readinessScore,
  });

  factory ProgressMetric.fromJson(Map<String, dynamic> json) {
    return ProgressMetric(
      day: json['day'] ?? '',
      skillScore: (json['skillScore'] as num?)?.toDouble() ?? 0.0,
      interviewScore: (json['interviewScore'] as num?)?.toDouble() ?? 0.0,
      readinessScore: (json['readinessScore'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'skillScore': skillScore,
      'interviewScore': interviewScore,
      'readinessScore': readinessScore,
    };
  }
}
