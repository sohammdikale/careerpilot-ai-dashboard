from typing import List, Dict, Any, Optional

class DataStore:
    def __init__(self):
        self.profile = {
            "name": "Alex Sharma",
            "title": "Aspiring Machine Learning Engineer",
            "targetRole": "Machine Learning Engineer",
            "bio": "Computer Science student specializing in AI/ML & Deep Learning. Focused on scalable LLM deployment and MLOps.",
            "email": "alex.sharma@university.edu",
            "location": "San Francisco, CA",
            "readinessScore": 84,
            "avatarUrl": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=400",
            "completedMilestones": 8,
            "totalMilestones": 12,
        }

        self.skills = [
            {"id": "1", "name": "Python & NumPy", "category": "AI/ML", "proficiency": 0.95, "status": "Mastered", "isTargetRequired": True},
            {"id": "2", "name": "PyTorch & Transformers", "category": "AI/ML", "proficiency": 0.88, "status": "Mastered", "isTargetRequired": True},
            {"id": "3", "name": "MLOps & Docker", "category": "Cloud", "proficiency": 0.65, "status": "In Progress", "isTargetRequired": True},
            {"id": "4", "name": "Kubernetes & Kubeflow", "category": "Cloud", "proficiency": 0.35, "status": "Skill Gap", "isTargetRequired": True},
            {"id": "5", "name": "FastAPI & REST Services", "category": "Backend", "proficiency": 0.82, "status": "Mastered", "isTargetRequired": False},
            {"id": "6", "name": "SQL & Vector Databases", "category": "Data", "proficiency": 0.78, "status": "In Progress", "isTargetRequired": True},
            {"id": "7", "name": "TensorRT Optimization", "category": "AI/ML", "proficiency": 0.40, "status": "Skill Gap", "isTargetRequired": True},
        ]

        self.roadmap = [
            {
                "id": "m1",
                "title": "Math & Statistical Foundations",
                "phase": "Phase 1: Foundations",
                "description": "Master Linear Algebra, Calculus, Probability, and Vector Calculus essentials for Neural Networks.",
                "isCompleted": True,
                "duration": "3 Weeks",
                "skillsCovered": ["Linear Algebra", "Multivariate Calculus", "Probability Theory"],
            },
            {
                "id": "m2",
                "title": "Classical Machine Learning",
                "phase": "Phase 1: Foundations",
                "description": "Scikit-Learn algorithms, Random Forests, XGBoost, Regression models, and Cross-Validation techniques.",
                "isCompleted": True,
                "duration": "4 Weeks",
                "skillsCovered": ["Scikit-Learn", "Feature Engineering", "XGBoost"],
            },
            {
                "id": "m3",
                "title": "Deep Learning & PyTorch",
                "phase": "Phase 2: Core ML",
                "description": "Convolutional Nets, Recurrent Architectures, Attention Mechanism, and PyTorch Lightning.",
                "isCompleted": True,
                "duration": "5 Weeks",
                "skillsCovered": ["PyTorch", "CNNs", "Transformers Architecture"],
            },
            {
                "id": "m4",
                "title": "Large Language Models & Fine-Tuning",
                "phase": "Phase 2: Core ML",
                "description": "HuggingFace Transformers, LoRA/QLoRA Parameter Efficient Fine-Tuning, and RAG pipelines.",
                "isCompleted": False,
                "duration": "4 Weeks",
                "skillsCovered": ["HuggingFace", "LoRA / PEFT", "LangChain", "Vector Indexing"],
            },
            {
                "id": "m5",
                "title": "Production MLOps & Deployment",
                "phase": "Phase 3: Deployment",
                "description": "Docker containerization, Model Serving via FastAPI, Prometheus Monitoring, and CI/CD pipelines.",
                "isCompleted": False,
                "duration": "6 Weeks",
                "skillsCovered": ["Docker", "Kubeflow", "Model Monitoring", "Triton Server"],
            },
        ]

        self.resume_analysis = {
            "overallAtsScore": 84,
            "impactScore": 88,
            "keywordMatchScore": 78,
            "formatScore": 92,
            "structureScore": 86,
            "suggestions": [
                {
                    "id": "rs1",
                    "section": "Impact",
                    "title": "Quantify Deep Learning achievements",
                    "description": 'Add measurable metrics to your PyTorch project (e.g. "Improved inference latency by 34% using ONNX runtime").',
                    "impactLevel": "High",
                    "isApplied": False,
                },
                {
                    "id": "rs2",
                    "section": "Keywords",
                    "title": "Missing MLOps keywords for ML Engineer roles",
                    "description": 'Include keywords like "MLOps", "Docker", "Model Monitoring", and "CI/CD" in your Skills section.',
                    "impactLevel": "High",
                    "isApplied": False,
                },
                {
                    "id": "rs3",
                    "section": "Formatting",
                    "title": "Standardize Bullet Point Verbs",
                    "description": 'Ensure all bullet points begin with strong action verbs in past tense (e.g., "Engineered", "Deployed", "Optimized").',
                    "impactLevel": "Medium",
                    "isApplied": False,
                },
            ],
        }

        self.projects = [
            {
                "id": "p1",
                "title": "High-Throughput RAG Pipeline with Vector Search",
                "domain": "LLM & Generative AI",
                "difficulty": "Intermediate",
                "description": "Build an end-to-end Retrieval Augmented Generation engine using Qdrant vector database, LangChain, and Llama 3 8B.",
                "tags": ["PyTorch", "Qdrant", "LangChain", "Llama 3"],
                "matchPercentage": 96,
                "estimatedDuration": "15 Hours",
                "isSaved": True,
                "isStarted": False,
            },
            {
                "id": "p2",
                "title": "Distributed Model Training with PyTorch FSDP",
                "domain": "ML Infrastructure",
                "difficulty": "Advanced",
                "description": "Implement Fully Sharded Data Parallelism to fine-tune 7B parameter models across multi-GPU setups.",
                "tags": ["PyTorch FSDP", "Docker", "Distributed ML", "CUDA"],
                "matchPercentage": 88,
                "estimatedDuration": "25 Hours",
                "isSaved": False,
                "isStarted": False,
            },
            {
                "id": "p3",
                "title": "Real-Time Fraud Detection Stream with Kafka",
                "domain": "Data Engineering",
                "difficulty": "Intermediate",
                "description": "Process financial transactions stream via Apache Kafka, apply XGBoost anomaly detection, and visualize via Streamlit.",
                "tags": ["Kafka", "XGBoost", "Python", "FastAPI"],
                "matchPercentage": 82,
                "estimatedDuration": "18 Hours",
                "isSaved": False,
                "isStarted": False,
            },
        ]

        self.interviews = [
            {
                "id": "i1",
                "question": "Explain how attention mechanisms work in Transformer architectures and how Query, Key, and Value matrices interact.",
                "category": "Deep Learning",
                "difficulty": "Hard",
                "userAudioPath": None,
                "userTranscript": "In self-attention, input tokens are mapped into Query, Key, and Value vectors via linear projection matrices. We compute the dot product of Query and Key to obtain attention weights...",
                "overallScore": 88,
                "clarityScore": 90,
                "technicalDepthScore": 86,
                "confidenceScore": 88,
                "aiFeedback": "Excellent explanation of QKV dot products and scaling factors! To make it outstanding, explicitly mention why division by sqrt(d_k) prevents vanishing gradients.",
            },
            {
                "id": "i2",
                "question": "How do you handle severe class imbalance in a fraud detection dataset?",
                "category": "Machine Learning",
                "difficulty": "Medium",
                "userAudioPath": None,
                "userTranscript": None,
                "overallScore": None,
                "clarityScore": None,
                "technicalDepthScore": None,
                "confidenceScore": None,
                "aiFeedback": None,
            },
        ]

        self.analytics = [
            {"day": "Mon", "skillScore": 68.0, "interviewScore": 70.0, "readinessScore": 72.0},
            {"day": "Tue", "skillScore": 72.0, "interviewScore": 74.0, "readinessScore": 75.0},
            {"day": "Wed", "skillScore": 75.0, "interviewScore": 76.0, "readinessScore": 78.0},
            {"day": "Thu", "skillScore": 79.0, "interviewScore": 82.0, "readinessScore": 81.0},
            {"day": "Fri", "skillScore": 82.0, "interviewScore": 85.0, "readinessScore": 83.0},
            {"day": "Sat", "skillScore": 85.0, "interviewScore": 87.0, "readinessScore": 84.0},
            {"day": "Sun", "skillScore": 88.0, "interviewScore": 88.0, "readinessScore": 86.0},
        ]

db = DataStore()
