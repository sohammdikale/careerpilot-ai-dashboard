import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../services/api_service.dart';

class AppState extends ChangeNotifier {
  int _currentScreenIndex = 0;
  bool _isDarkMode = false;
  String _selectedTargetRole = 'Machine Learning Engineer';

  // Backend Integration
  ApiService _apiService = ApiService();
  bool _isBackendConnected = false;
  bool _isSyncing = false;
  String _serverUrl = 'http://10.0.2.2:8000';

  int get currentScreenIndex => _currentScreenIndex;
  bool get isDarkMode => _isDarkMode;
  String get selectedTargetRole => _selectedTargetRole;

  bool get isBackendConnected => _isBackendConnected;
  bool get isSyncing => _isSyncing;
  String get serverUrl => _serverUrl;
  ApiService get apiService => _apiService;

  AppState() {
    _initBackend();
  }

  Future<void> _initBackend() async {
    await testAndSyncBackend(_serverUrl);
  }

  Future<bool> testAndSyncBackend(String url) async {
    _serverUrl = url.trim();
    _apiService = ApiService(baseUrl: _serverUrl);
    _isSyncing = true;
    notifyListeners();

    final isHealthy = await _apiService.checkHealth();
    _isBackendConnected = isHealthy;

    if (isHealthy) {
      await fetchInitialData();
    }

    _isSyncing = false;
    notifyListeners();
    return isHealthy;
  }

  Future<void> fetchInitialData() async {
    if (!_isBackendConnected) return;

    final p = await _apiService.fetchProfile();
    if (p != null) {
      userProfile.name = p.name;
      userProfile.title = p.title;
      userProfile.targetRole = p.targetRole;
      userProfile.bio = p.bio;
      userProfile.email = p.email;
      userProfile.location = p.location;
      userProfile.readinessScore = p.readinessScore;
      userProfile.avatarUrl = p.avatarUrl;
      userProfile.completedMilestones = p.completedMilestones;
      userProfile.totalMilestones = p.totalMilestones;
    }

    final sList = await _apiService.fetchSkills();
    if (sList != null) {
      skills.clear();
      skills.addAll(sList);
    }

    final rList = await _apiService.fetchRoadmap();
    if (rList != null) {
      roadmap.clear();
      roadmap.addAll(rList);
    }

    final resAnalysis = await _apiService.fetchResumeAnalysis();
    if (resAnalysis != null) {
      resumeAnalysis.overallAtsScore = resAnalysis.overallAtsScore;
      resumeAnalysis.impactScore = resAnalysis.impactScore;
      resumeAnalysis.keywordMatchScore = resAnalysis.keywordMatchScore;
      resumeAnalysis.formatScore = resAnalysis.formatScore;
      resumeAnalysis.structureScore = resAnalysis.structureScore;
      resumeAnalysis.suggestions = resAnalysis.suggestions;
    }

    final pList = await _apiService.fetchProjects();
    if (pList != null) {
      projects.clear();
      projects.addAll(pList);
    }

    final iList = await _apiService.fetchInterviews();
    if (iList != null) {
      mockInterviews.clear();
      mockInterviews.addAll(iList);
    }

    final aList = await _apiService.fetchAnalytics();
    if (aList != null) {
      progressMetrics.clear();
      progressMetrics.addAll(aList);
    }

    notifyListeners();
  }

  void setScreenIndex(int index) {
    _currentScreenIndex = index;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setTargetRole(String role) {
    _selectedTargetRole = role;
    notifyListeners();
  }

  // User Profile
  final UserProfile userProfile = UserProfile(
    name: 'Alex Sharma',
    title: 'Aspiring Machine Learning Engineer',
    targetRole: 'Machine Learning Engineer',
    bio: 'Computer Science student specializing in AI/ML & Deep Learning. Focused on scalable LLM deployment and MLOps.',
    email: 'alex.sharma@university.edu',
    location: 'San Francisco, CA',
    readinessScore: 84,
    avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=400',
    completedMilestones: 8,
    totalMilestones: 12,
  );

  Future<void> updateUserProfile({
    required String name,
    required String title,
    required String targetRole,
    required String bio,
    required String location,
  }) async {
    userProfile.name = name;
    userProfile.title = title;
    userProfile.targetRole = targetRole;
    userProfile.bio = bio;
    userProfile.location = location;
    notifyListeners();

    if (_isBackendConnected) {
      final updated = await _apiService.updateProfile(
        name: name,
        title: title,
        targetRole: targetRole,
        bio: bio,
        location: location,
      );
      if (updated != null) {
        userProfile.readinessScore = updated.readinessScore;
        notifyListeners();
      }
    }
  }

  // Skills Data
  final List<SkillItem> skills = [
    SkillItem(id: '1', name: 'Python & NumPy', category: 'AI/ML', proficiency: 0.95, status: 'Mastered', isTargetRequired: true),
    SkillItem(id: '2', name: 'PyTorch & Transformers', category: 'AI/ML', proficiency: 0.88, status: 'Mastered', isTargetRequired: true),
    SkillItem(id: '3', name: 'MLOps & Docker', category: 'Cloud', proficiency: 0.65, status: 'In Progress', isTargetRequired: true),
    SkillItem(id: '4', name: 'Kubernetes & Kubeflow', category: 'Cloud', proficiency: 0.35, status: 'Skill Gap', isTargetRequired: true),
    SkillItem(id: '5', name: 'FastAPI & REST Services', category: 'Backend', proficiency: 0.82, status: 'Mastered', isTargetRequired: false),
    SkillItem(id: '6', name: 'SQL & Vector Databases', category: 'Data', proficiency: 0.78, status: 'In Progress', isTargetRequired: true),
    SkillItem(id: '7', name: 'TensorRT Optimization', category: 'AI/ML', proficiency: 0.40, status: 'Skill Gap', isTargetRequired: true),
  ];

  Future<void> addSkill(SkillItem item) async {
    skills.add(item);
    notifyListeners();

    if (_isBackendConnected) {
      final res = await _apiService.addSkill(
        name: item.name,
        category: item.category,
        proficiency: item.proficiency,
        isTargetRequired: item.isTargetRequired,
      );
      if (res != null) {
        final idx = skills.indexWhere((s) => s.id == item.id);
        if (idx != -1) {
          skills[idx] = res;
          notifyListeners();
        }
      }
    }
  }

  Future<void> updateSkillProficiency(String id, double val) async {
    final idx = skills.indexWhere((s) => s.id == id);
    if (idx != -1) {
      skills[idx].proficiency = val;
      if (val >= 0.8) {
        skills[idx].status = 'Mastered';
      } else if (val >= 0.5) {
        skills[idx].status = 'In Progress';
      } else {
        skills[idx].status = 'Skill Gap';
      }
      notifyListeners();

      if (_isBackendConnected) {
        final updated = await _apiService.updateSkillProficiency(id, val);
        if (updated != null) {
          skills[idx] = updated;
          notifyListeners();
        }
      }
    }
  }

  // Roadmap Data
  final List<RoadmapMilestone> roadmap = [
    RoadmapMilestone(
      id: 'm1',
      title: 'Math & Statistical Foundations',
      phase: 'Phase 1: Foundations',
      description: 'Master Linear Algebra, Calculus, Probability, and Vector Calculus essentials for Neural Networks.',
      isCompleted: true,
      duration: '3 Weeks',
      skillsCovered: ['Linear Algebra', 'Multivariate Calculus', 'Probability Theory'],
    ),
    RoadmapMilestone(
      id: 'm2',
      title: 'Classical Machine Learning',
      phase: 'Phase 1: Foundations',
      description: 'Scikit-Learn algorithms, Random Forests, XGBoost, Regression models, and Cross-Validation techniques.',
      isCompleted: true,
      duration: '4 Weeks',
      skillsCovered: ['Scikit-Learn', 'Feature Engineering', 'XGBoost'],
    ),
    RoadmapMilestone(
      id: 'm3',
      title: 'Deep Learning & PyTorch',
      phase: 'Phase 2: Core ML',
      description: 'Convolutional Nets, Recurrent Architectures, Attention Mechanism, and PyTorch Lightning.',
      isCompleted: true,
      duration: '5 Weeks',
      skillsCovered: ['PyTorch', 'CNNs', 'Transformers Architecture'],
    ),
    RoadmapMilestone(
      id: 'm4',
      title: 'Large Language Models & Fine-Tuning',
      phase: 'Phase 2: Core ML',
      description: 'HuggingFace Transformers, LoRA/QLoRA Parameter Efficient Fine-Tuning, and RAG pipelines.',
      isCompleted: false,
      duration: '4 Weeks',
      skillsCovered: ['HuggingFace', 'LoRA / PEFT', 'LangChain', 'Vector Indexing'],
    ),
    RoadmapMilestone(
      id: 'm5',
      title: 'Production MLOps & Deployment',
      phase: 'Phase 3: Deployment',
      description: 'Docker containerization, Model Serving via FastAPI, Prometheus Monitoring, and CI/CD pipelines.',
      isCompleted: false,
      duration: '6 Weeks',
      skillsCovered: ['Docker', 'Kubeflow', 'Model Monitoring', 'Triton Server'],
    ),
  ];

  Future<void> toggleRoadmapMilestone(String id) async {
    final idx = roadmap.indexWhere((m) => m.id == id);
    if (idx != -1) {
      roadmap[idx].isCompleted = !roadmap[idx].isCompleted;
      userProfile.completedMilestones = roadmap.where((m) => m.isCompleted).length;
      notifyListeners();

      if (_isBackendConnected) {
        final res = await _apiService.toggleRoadmapMilestone(id);
        if (res != null) {
          roadmap[idx] = res;
          userProfile.completedMilestones = roadmap.where((m) => m.isCompleted).length;
          notifyListeners();
        }
      }
    }
  }

  // Resume Intelligence Data
  final ResumeAnalysis resumeAnalysis = ResumeAnalysis(
    overallAtsScore: 84,
    impactScore: 88,
    keywordMatchScore: 78,
    formatScore: 92,
    structureScore: 86,
    suggestions: [
      ResumeSuggestion(
        id: 'rs1',
        section: 'Impact',
        title: 'Quantify Deep Learning achievements',
        description: 'Add measurable metrics to your PyTorch project (e.g. "Improved inference latency by 34% using ONNX runtime").',
        impactLevel: 'High',
      ),
      ResumeSuggestion(
        id: 'rs2',
        section: 'Keywords',
        title: 'Missing MLOps keywords for ML Engineer roles',
        description: 'Include keywords like "MLOps", "Docker", "Model Monitoring", and "CI/CD" in your Skills section.',
        impactLevel: 'High',
      ),
      ResumeSuggestion(
        id: 'rs3',
        section: 'Formatting',
        title: 'Standardize Bullet Point Verbs',
        description: 'Ensure all bullet points begin with strong action verbs in past tense (e.g., "Engineered", "Deployed", "Optimized").',
        impactLevel: 'Medium',
      ),
    ],
  );

  Future<void> applyResumeSuggestion(String id) async {
    final idx = resumeAnalysis.suggestions.indexWhere((s) => s.id == id);
    if (idx != -1) {
      resumeAnalysis.suggestions[idx].isApplied = true;
      resumeAnalysis.overallAtsScore = (resumeAnalysis.overallAtsScore + 3).clamp(0, 100);
      notifyListeners();

      if (_isBackendConnected) {
        final res = await _apiService.applyResumeSuggestion(id);
        if (res != null) {
          resumeAnalysis.overallAtsScore = res.overallAtsScore;
          resumeAnalysis.suggestions = res.suggestions;
          notifyListeners();
        }
      }
    }
  }

  // Projects Data
  final List<ProjectRecommendation> projects = [
    ProjectRecommendation(
      id: 'p1',
      title: 'High-Throughput RAG Pipeline with Vector Search',
      domain: 'LLM & Generative AI',
      difficulty: 'Intermediate',
      description: 'Build an end-to-end Retrieval Augmented Generation engine using Qdrant vector database, LangChain, and Llama 3 8B.',
      tags: ['PyTorch', 'Qdrant', 'LangChain', 'Llama 3'],
      matchPercentage: 96,
      estimatedDuration: '15 Hours',
      isSaved: true,
    ),
    ProjectRecommendation(
      id: 'p2',
      title: 'Distributed Model Training with PyTorch FSDP',
      domain: 'ML Infrastructure',
      difficulty: 'Advanced',
      description: 'Implement Fully Sharded Data Parallelism to fine-tune 7B parameter models across multi-GPU setups.',
      tags: ['PyTorch FSDP', 'Docker', 'Distributed ML', 'CUDA'],
      matchPercentage: 88,
      estimatedDuration: '25 Hours',
    ),
    ProjectRecommendation(
      id: 'p3',
      title: 'Real-Time Fraud Detection Stream with Kafka',
      domain: 'Data Engineering',
      difficulty: 'Intermediate',
      description: 'Process financial transactions stream via Apache Kafka, apply XGBoost anomaly detection, and visualize via Streamlit.',
      tags: ['Kafka', 'XGBoost', 'Python', 'FastAPI'],
      matchPercentage: 82,
      estimatedDuration: '18 Hours',
    ),
  ];

  Future<void> toggleSaveProject(String id) async {
    final idx = projects.indexWhere((p) => p.id == id);
    if (idx != -1) {
      projects[idx].isSaved = !projects[idx].isSaved;
      notifyListeners();

      if (_isBackendConnected) {
        final res = await _apiService.toggleSaveProject(id);
        if (res != null) {
          projects[idx] = res;
          notifyListeners();
        }
      }
    }
  }

  // Mock Interview Data
  final List<MockInterviewSession> mockInterviews = [
    MockInterviewSession(
      id: 'i1',
      question: 'Explain how attention mechanisms work in Transformer architectures and how Query, Key, and Value matrices interact.',
      category: 'Deep Learning',
      difficulty: 'Hard',
      userTranscript: 'In self-attention, input tokens are mapped into Query, Key, and Value vectors via linear projection matrices. We compute the dot product of Query and Key to obtain attention weights...',
      overallScore: 88,
      clarityScore: 90,
      technicalDepthScore: 86,
      confidenceScore: 88,
      aiFeedback: 'Excellent explanation of QKV dot products and scaling factors! To make it outstanding, explicitly mention why division by sqrt(d_k) prevents vanishing gradients.',
    ),
    MockInterviewSession(
      id: 'i2',
      question: 'How do you handle severe class imbalance in a fraud detection dataset?',
      category: 'Machine Learning',
      difficulty: 'Medium',
    ),
  ];

  Future<void> evaluateMockInterview({
    required String sessionId,
    required String transcript,
  }) async {
    final idx = mockInterviews.indexWhere((i) => i.id == sessionId);
    if (idx != -1) {
      mockInterviews[idx].userTranscript = transcript;
      
      // Fallback local evaluation logic if backend is offline
      int wordCount = transcript.trim().split(' ').length;
      int clarity = (70 + (wordCount ~/ 3)).clamp(60, 95);
      int techDepth = (75 + (transcript.toLowerCase().contains('gradient') ? 10 : 0)).clamp(60, 95);
      int confidence = (72 + (wordCount ~/ 4)).clamp(60, 95);
      int overall = (clarity + techDepth + confidence) ~/ 3;

      mockInterviews[idx].overallScore = overall;
      mockInterviews[idx].clarityScore = clarity;
      mockInterviews[idx].technicalDepthScore = techDepth;
      mockInterviews[idx].confidenceScore = confidence;
      mockInterviews[idx].aiFeedback = "Good answer! Covered key concepts in $wordCount words.";

      notifyListeners();

      if (_isBackendConnected) {
        final res = await _apiService.evaluateInterview(
          sessionId: sessionId,
          transcript: transcript,
        );
        if (res != null) {
          mockInterviews[idx] = res;
          notifyListeners();
        }
      }
    }
  }

  // Progress Analytics Metrics
  final List<ProgressMetric> progressMetrics = [
    ProgressMetric(day: 'Mon', skillScore: 68, interviewScore: 70, readinessScore: 72),
    ProgressMetric(day: 'Tue', skillScore: 72, interviewScore: 74, readinessScore: 75),
    ProgressMetric(day: 'Wed', skillScore: 75, interviewScore: 76, readinessScore: 78),
    ProgressMetric(day: 'Thu', skillScore: 79, interviewScore: 82, readinessScore: 81),
    ProgressMetric(day: 'Fri', skillScore: 82, interviewScore: 85, readinessScore: 83),
    ProgressMetric(day: 'Sat', skillScore: 85, interviewScore: 87, readinessScore: 84),
    ProgressMetric(day: 'Sun', skillScore: 88, interviewScore: 88, readinessScore: 86),
  ];
}
