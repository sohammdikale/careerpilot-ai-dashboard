# 🚀 CareerPilot AI Dashboard

### AI-Powered Career Growth & Job-Readiness Platform

CareerPilot AI Dashboard is an intelligent career development platform designed to help students and job seekers understand their career readiness, identify skill gaps, improve their resumes, follow personalized career roadmaps, discover relevant projects, and practice interviews with AI-powered feedback.

Built with **Flutter** and **Python FastAPI**, CareerPilot provides a modern dashboard experience with a connected REST API backend.

---

## 🎯 Problem Statement

Students and job seekers often struggle to understand:

* What skills are required for their target role
* Which skills they are currently missing
* Whether their resume is ATS-friendly
* Which projects they should build
* How to prepare for technical interviews
* How to track their career preparation progress

CareerPilot brings these activities into a single platform and provides actionable, personalized career guidance.

---

## 💡 Solution

CareerPilot AI analyzes a user's career profile, skills, resume, and target role to provide:

> **Career Readiness → Skill Gap → Roadmap → Projects → Resume Improvement → Interview Preparation → Progress Tracking**

This creates a complete career-preparation workflow instead of relying on multiple disconnected tools.

---

## ✨ Key Features

### ⚡ AI Career Readiness

Get an overall understanding of your readiness for a selected target role.

* Target role compatibility
* Readiness score
* High-impact improvement areas
* Actionable career recommendations

---

### 🎯 Skill Gap Analysis

Understand the difference between your current skills and the skills required for your target role.

* Skill proficiency tracking
* Target-role requirements
* Skill gap identification
* Category-wise analysis
* Progress tracking

Supported areas include:

* 🤖 AI / Machine Learning
* ☁️ Cloud & MLOps
* ⚙️ Backend Development
* 📊 Data Engineering

---

### 🗺️ Interactive Career Roadmap

Follow a structured learning path toward your target career.

Example:

```text
Foundation
    ↓
Programming & Mathematics
    ↓
Core Machine Learning
    ↓
Deep Learning
    ↓
MLOps & Deployment
    ↓
Real-World Projects
    ↓
Interview Preparation
```

Users can track completed milestones and monitor their progress.

---

### 📄 Resume Intelligence & ATS Evaluation

Analyze your resume and identify areas that can be improved.

The resume intelligence module provides:

* ATS compatibility score
* Keyword coverage
* Resume structure analysis
* Impact metrics
* Formatting insights
* AI-powered improvement suggestions

Users can review suggestions and apply relevant improvements.

---

### 💡 AI Project Recommendations

Get project ideas based on your target role and current skill profile.

Each recommendation can include:

* Project title
* Domain
* Difficulty level
* Estimated completion time
* Skill requirements
* Match score
* Save/bookmark functionality

This helps users build projects that are relevant to their career goals rather than choosing random projects.

---

### 🎙️ AI Mock Interview Coach

Practice technical interviews through the platform.

The interview module evaluates responses based on:

* 🗣️ Clarity
* 🧠 Technical depth
* 💪 Confidence
* 📝 Overall response quality

The system provides actionable feedback to help users improve their interview performance.

---

### 📊 Progress Analytics

Track career preparation over time through interactive analytics.

Metrics include:

* Weekly progress
* Study streak
* Score trends
* Career preparation activity

---

### 🔌 REST API Backend

CareerPilot uses a Python FastAPI backend to communicate with the Flutter application.

The backend provides:

* RESTful API endpoints
* Data validation with Pydantic
* CORS support
* Profile management
* Skill management
* Resume data
* Roadmap data
* Project recommendations
* Interview evaluation
* Analytics

Interactive API documentation is available through FastAPI Swagger UI.

---

# 🏗️ System Architecture

```text
                 ┌─────────────────────┐
                 │        USER         │
                 └──────────┬──────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │   Flutter Frontend  │
                 │   Mobile Dashboard  │
                 └──────────┬──────────┘
                            │
                       REST API
                            │
                            ▼
                 ┌─────────────────────┐
                 │   FastAPI Backend   │
                 │    Python Server    │
                 └──────────┬──────────┘
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
          ▼                 ▼                 ▼
   ┌─────────────┐   ┌─────────────┐   ┌─────────────┐
   │ Resume / ATS│   │ Skill Gap   │   │ Career      │
   │ Intelligence│   │ Analysis    │   │ Roadmap     │
   └─────────────┘   └─────────────┘   └─────────────┘
          │                 │                 │
          └─────────────────┼─────────────────┘
                            │
                            ▼
                  ┌───────────────────┐
                  │ Career Insights & │
                  │ Recommendations   │
                  └───────────────────┘
                            │
                            ▼
                  ┌───────────────────┐
                  │ User Progress &   │
                  │ Interview Feedback│
                  └───────────────────┘
```

---

# 🛠️ Tech Stack

## Frontend

* **Flutter**
* **Dart**
* Provider
* fl_chart
* REST API integration
* Responsive UI

## Backend

* **Python**
* **FastAPI**
* **Uvicorn**
* **Pydantic**
* REST APIs
* CORS middleware

## AI / Intelligence

* Resume analysis
* ATS scoring
* Skill-gap analysis
* Career matching
* Project recommendation
* Interview response evaluation

## Development Tools

* Git
* GitHub
* VS Code
* Android Studio
* Flutter SDK

---

# 📂 Project Structure

```text
careerpilot-ai-dashboard/
│
├── careerpilot_app/
│   │
│   ├── lib/
│   │   ├── models/
│   │   │   └── JSON data models
│   │   │
│   │   ├── providers/
│   │   │   └── State management & API synchronization
│   │   │
│   │   ├── screens/
│   │   │   └── Dashboard, Resume, Skills, Roadmap,
│   │   │       Projects, Mock Interview, Analytics
│   │   │
│   │   ├── services/
│   │   │   └── HTTP API client
│   │   │
│   │   ├── theme/
│   │   │   └── Theme & typography
│   │   │
│   │   └── widgets/
│   │       └── Reusable UI components
│   │
│   ├── backend/
│   │   ├── main.py
│   │   ├── schemas.py
│   │   ├── store.py
│   │   ├── run_backend.py
│   │   └── requirements.txt
│   │
│   └── build/
│       └── app-release.apk
│
├── stitch_careerpilot_ai_dashboard/
│
├── .gitignore
└── README.md
```

The repository currently contains the Flutter application and its FastAPI backend, with separate model, provider, screen, service, theme, and widget layers.

---

# 🔄 Application Workflow

```text
User Creates Career Profile
            ↓
      Select Target Role
            ↓
      Enter / Update Skills
            ↓
     CareerPilot Analysis
            ↓
 ┌──────────┼──────────┐
 ↓          ↓          ↓
Skill     Resume     Career
Gap       ATS        Roadmap
 ↓          ↓          ↓
 └──────────┼──────────┘
            ↓
   Project Recommendations
            ↓
   Mock Interview Practice
            ↓
     AI Feedback & Scores
            ↓
      Progress Analytics
```

---

# 🌐 API Endpoints

| Method       | Endpoint                            | Purpose                         |
| ------------ | ----------------------------------- | ------------------------------- |
| `GET`        | `/health`                           | Check backend health            |
| `GET / PUT`  | `/api/profile`                      | Get or update user profile      |
| `GET / POST` | `/api/skills`                       | Manage user skills              |
| `PUT`        | `/api/skills/{id}`                  | Update skill proficiency        |
| `GET`        | `/api/roadmap`                      | Get career roadmap              |
| `POST`       | `/api/roadmap/{id}/toggle`          | Mark roadmap milestone          |
| `GET`        | `/api/resume`                       | Get ATS resume analysis         |
| `POST`       | `/api/resume/apply-suggestion/{id}` | Apply resume suggestion         |
| `GET`        | `/api/projects`                     | Get project recommendations     |
| `POST`       | `/api/projects/{id}/toggle-save`    | Save a project                  |
| `GET`        | `/api/interviews`                   | Get interview questions/history |
| `POST`       | `/api/interviews/evaluate`          | Evaluate interview response     |
| `GET`        | `/api/analytics`                    | Get progress analytics          |

The current repository exposes these FastAPI routes for profile, skills, roadmap, resume, projects, interviews, and analytics functionality.

---

# 🚀 Getting Started

## Prerequisites

Make sure you have installed:

* Flutter SDK `3.12+`
* Python `3.10+`
* Git
* Android Studio or another Flutter-supported development environment

---

## 1️⃣ Clone the Repository

```bash
git clone https://github.com/sohammdikale/careerpilot-ai-dashboard.git
```

```bash
cd careerpilot-ai-dashboard
```

---

## 2️⃣ Start the FastAPI Backend

Navigate to the backend:

```bash
cd careerpilot_app/backend
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Start the backend:

```bash
python run_backend.py
```

The API server runs on:

```text
http://localhost:8000
```

FastAPI documentation:

```text
http://localhost:8000/docs
```

---

## 3️⃣ Run the Flutter Application

Open another terminal:

```bash
cd careerpilot_app
```

Install Flutter dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

---

# 📱 Android APK

A release APK is included in the project build outputs:

```text
careerpilot_app/build/app/outputs/flutter-apk/app-release.apk
```

You can transfer the APK to an Android device and install it directly.

> For security reasons, Android may require permission to install applications from unknown sources.

---

# 🎨 UI & Design

CareerPilot follows a modern dashboard-oriented design focused on:

* Minimal navigation
* Clear information hierarchy
* Career progress visualization
* Interactive cards
* Skill progress indicators
* Charts and analytics
* Dark / light theme support
* Mobile-friendly layouts

The Flutter application uses reusable widgets, centralized theme definitions, and Provider-based state management to keep the interface modular and maintainable.

---

# 🧠 Core Concepts Demonstrated

This project demonstrates practical concepts in:

### Artificial Intelligence

* AI-powered recommendations
* Resume intelligence
* Career matching
* Interview evaluation

### Software Development

* REST API architecture
* Client-server communication
* State management
* JSON serialization
* Data validation
* API integration

### Mobile Development

* Flutter
* Dart
* Cross-platform application development
* Reusable UI components
* Responsive dashboard design

### Backend Development

* Python
* FastAPI
* REST APIs
* Pydantic schemas
* Uvicorn
* CORS

---

# 🔮 Future Scope

CareerPilot can be expanded with:

* 🤖 Advanced LLM-powered career assistant
* 📄 Automatic PDF/DOCX resume parsing
* 🔍 Real-time job recommendations
* 💼 Job application tracking
* 🔗 LinkedIn profile analysis
* 🧠 Personalized learning recommendations
* 📚 Course and certification recommendations
* 🎤 Advanced voice-based interviews
* 🗣️ Speech-to-text interview analysis
* 📊 Advanced career analytics
* ☁️ Cloud deployment
* 🔐 User authentication
* 🗄️ Production database integration
* 👥 Multi-user profiles
* 🌐 Web dashboard version

---

# 📌 Project Highlights

| Area             | Implementation     |
| ---------------- | ------------------ |
| Mobile App       | Flutter            |
| Backend          | Python FastAPI     |
| API              | REST               |
| State Management | Provider           |
| Resume Analysis  | ATS Intelligence   |
| Career Analysis  | Skill Gap          |
| Planning         | Career Roadmap     |
| Projects         | AI Recommendations |
| Interviews       | AI Evaluation      |
| Analytics        | Interactive Charts |
| Deployment       | Android APK        |

---

# 🎓 Educational Purpose

CareerPilot AI Dashboard was developed as a practical project to explore the integration of:

**Artificial Intelligence + Mobile Development + Backend APIs + Career Analytics**

The project demonstrates how multiple technologies can be combined into a single real-world application that addresses a practical problem faced by students and job seekers.

---

# 🤝 Contributing

Contributions and suggestions are welcome.

### Steps

1. Fork the repository
2. Create a new branch

```bash
git checkout -b feature/your-feature
```

3. Make your changes
4. Commit your changes

```bash
git commit -m "Add your feature"
```

5. Push your branch

```bash
git push origin feature/your-feature
```

6. Open a Pull Request

---

# ⭐ Support

If you find **CareerPilot AI Dashboard** useful or interesting, consider giving the repository a ⭐ on GitHub.

**Repository:**
https://github.com/sohammdikale/careerpilot-ai-dashboard

---

# 👨‍💻 Author

## Soham Dikale

**B.Tech — Artificial Intelligence & Data Science**

Interested in:

* 🤖 Artificial Intelligence
* 🧠 Machine Learning
* 📊 Data Science
* 🐍 Python
* 📱 Flutter
* 🌐 Full-Stack Development

---

# 📄 License

This project is distributed under the **MIT License**.

See the `LICENSE` file for more information.
