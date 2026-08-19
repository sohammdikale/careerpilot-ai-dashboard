# 🚀 CareerPilot AI Dashboard

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-009688?logo=fastapi)](https://fastapi.tiangolo.com)
[![Python](https://img.shields.io/badge/Python-3.10+-3776AB?logo=python)](https://python.org)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

**CareerPilot AI Dashboard** is a state-of-the-art career growth and job-readiness intelligence platform. Powered by a **Flutter** mobile frontend and a **Python FastAPI** backend service, CareerPilot provides real-time ATS resume scoring, AI-driven skill gap detection, interactive career roadmaps, hands-on project recommendations, and an AI voice mock interview coach.

---

## ✨ Key Features

- **⚡ AI Readiness Engine**: Calculates target role compatibility (e.g. *Machine Learning Engineer*) and highlights immediate high-impact actions.
- **🎯 Skill Gap Analysis**: Interactive proficiencies across AI/ML, Cloud/MLOps, Backend, and Data Engineering with target role requirements.
- **🗺️ Interactive Career Roadmap**: Structured multi-phase milestones (*Foundations*, *Core ML*, *Production Deployment*) with progress tracking.
- **📄 Resume Intelligence (ATS Evaluator)**: Detailed breakdown of ATS compatibility scores, impact metrics, keyword coverage, formatting structure, and 1-click AI suggestions.
- **💡 AI Project Recommendations**: Customized hands-on projects with domain tags, difficulty ratings, estimated completion times, and match scores.
- **🎙️ AI Mock Interview Coach**: Real-time voice/text answer submission with AI scoring across *Clarity*, *Technical Depth*, and *Confidence*, paired with actionable coach feedback.
- **📈 Progress Analytics**: Interactive weekly trend charts powered by `fl_chart` tracking study streak and score trajectory.
- **🔌 Configurable REST Backend**: Live sync with FastAPI server, featuring preset connection chips for Android Emulator (`10.0.2.2:8000`), Localhost (`localhost:8000`), or custom LAN IP, plus graceful offline fallback.

---

## 🛠️ Tech Stack & Architecture

```
careerpilot-ai-dashboard/
├── careerpilot_app/               # Flutter Cross-Platform Application
│   ├── lib/
│   │   ├── models/                # App models with JSON serialization
│   │   ├── providers/             # State management (Provider) & API sync
│   │   ├── screens/               # 10 Screen modules (Dashboard, Resume, Mock Interview, etc.)
│   │   ├── services/              # HTTP API Service client
│   │   ├── theme/                 # Dark/Light color tokens & typography
│   │   └── widgets/               # Reusable UI shells & navigation drawer
│   └── backend/                   # Python FastAPI REST Backend
│       ├── main.py                # FastAPI routes & CORS middleware
│       ├── schemas.py             # Pydantic data validation schemas
│       ├── store.py               # Prepopulated CareerPilot data store
│       └── run_backend.py         # Uvicorn server runner script
```

---

## 🚀 Quick Start Guide

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.12`)
- [Python 3.10+](https://www.python.org/downloads/)

### 1. Start the FastAPI Backend Server
```bash
# Navigate to the backend directory
cd careerpilot_app/backend

# Install dependencies
pip install -r requirements.txt

# Launch server
python run_backend.py
```
> The API server starts on **`http://0.0.0.0:8000`**. You can view interactive API documentation at **`http://localhost:8000/docs`**.

### 2. Run the Flutter Mobile Application
```bash
# Navigate to the Flutter app directory
cd careerpilot_app

# Fetch dependencies
flutter pub get

# Launch app on device / emulator
flutter run
```

---

## 🌐 API Endpoint Reference

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/health` | Server health & readiness check |
| `GET` / `PUT` | `/api/profile` | Read and update user profile & target role |
| `GET` / `POST` | `/api/skills` | List skills or add a new skill |
| `PUT` | `/api/skills/{id}` | Update skill proficiency level |
| `GET` | `/api/roadmap` | Retrieve career roadmap milestones |
| `POST` | `/api/roadmap/{id}/toggle` | Toggle milestone completion status |
| `GET` | `/api/resume` | Fetch ATS resume score and suggestions |
| `POST` | `/api/resume/apply-suggestion/{id}` | Apply AI resume improvement suggestion |
| `GET` | `/api/projects` | List AI project recommendations |
| `POST` | `/api/projects/{id}/toggle-save` | Save or bookmark a project |
| `GET` | `/api/interviews` | List mock interview questions and history |
| `POST` | `/api/interviews/evaluate` | Evaluate interview response & return AI scores |
| `GET` | `/api/analytics` | Fetch weekly progress metrics |

---

## 📱 Android APK Installation

A pre-built release APK is available under the build outputs:
- **Location**: `careerpilot_app/build/app/outputs/flutter-apk/app-release.apk`

To install on your Android device:
1. Copy `app-release.apk` to your phone.
2. Open the file on your device and enable **Install from unknown sources** if prompted.
3. Tap **Install** and launch **CareerPilot AI**.

---

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.
