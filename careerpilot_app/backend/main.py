import uuid
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from store import db
from schemas import (
    UserProfileSchema,
    UserProfileUpdateSchema,
    SkillItemSchema,
    SkillCreateSchema,
    SkillUpdateProficiencySchema,
    RoadmapMilestoneSchema,
    ResumeAnalysisSchema,
    ProjectRecommendationSchema,
    MockInterviewSessionSchema,
    InterviewEvaluateRequestSchema,
    ProgressMetricSchema,
)
from typing import List

app = FastAPI(
    title="CareerPilot AI API",
    description="Backend API service for CareerPilot AI Dashboard",
    version="1.0.0",
)

# Enable CORS for web/mobile requests
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def root():
    return {
        "status": "online",
        "service": "CareerPilot AI Backend",
        "version": "1.0.0",
        "endpoints": [
            "/health",
            "/api/profile",
            "/api/skills",
            "/api/roadmap",
            "/api/resume",
            "/api/projects",
            "/api/interviews",
            "/api/analytics",
        ],
    }

@app.get("/health")
def health():
    return {"status": "ok", "app": "CareerPilot AI API"}

# --- PROFILE ENDPOINTS ---
@app.get("/api/profile", response_model=UserProfileSchema)
def get_profile():
    return db.profile

@app.put("/api/profile", response_model=UserProfileSchema)
def update_profile(data: UserProfileUpdateSchema):
    db.profile["name"] = data.name
    db.profile["title"] = data.title
    db.profile["targetRole"] = data.targetRole
    db.profile["bio"] = data.bio
    db.profile["location"] = data.location
    return db.profile

# --- SKILLS ENDPOINTS ---
@app.get("/api/skills", response_model=List[SkillItemSchema])
def get_skills():
    return db.skills

@app.post("/api/skills", response_model=SkillItemSchema)
def add_skill(data: SkillCreateSchema):
    new_id = str(uuid.uuid4())[:8]
    status = "Mastered" if data.proficiency >= 0.8 else ("In Progress" if data.proficiency >= 0.5 else "Skill Gap")
    new_skill = {
        "id": new_id,
        "name": data.name,
        "category": data.category,
        "proficiency": data.proficiency,
        "status": status,
        "isTargetRequired": data.isTargetRequired,
    }
    db.skills.append(new_skill)
    return new_skill

@app.put("/api/skills/{skill_id}", response_model=SkillItemSchema)
def update_skill_proficiency(skill_id: str, data: SkillUpdateProficiencySchema):
    for skill in db.skills:
        if skill["id"] == skill_id:
            skill["proficiency"] = data.proficiency
            if data.proficiency >= 0.8:
                skill["status"] = "Mastered"
            elif data.proficiency >= 0.5:
                skill["status"] = "In Progress"
            else:
                skill["status"] = "Skill Gap"
            return skill
    raise HTTPException(status_code=404, detail="Skill not found")

# --- ROADMAP ENDPOINTS ---
@app.get("/api/roadmap", response_model=List[RoadmapMilestoneSchema])
def get_roadmap():
    return db.roadmap

@app.post("/api/roadmap/{milestone_id}/toggle", response_model=RoadmapMilestoneSchema)
def toggle_roadmap_milestone(milestone_id: str):
    for item in db.roadmap:
        if item["id"] == milestone_id:
            item["isCompleted"] = not item["isCompleted"]
            # Recalculate completed count in profile
            completed = sum(1 for m in db.roadmap if m["isCompleted"])
            db.profile["completedMilestones"] = completed
            return item
    raise HTTPException(status_code=404, detail="Milestone not found")

# --- RESUME ENDPOINTS ---
@app.get("/api/resume", response_model=ResumeAnalysisSchema)
def get_resume_analysis():
    return db.resume_analysis

@app.post("/api/resume/apply-suggestion/{suggestion_id}", response_model=ResumeAnalysisSchema)
def apply_resume_suggestion(suggestion_id: str):
    for suggestion in db.resume_analysis["suggestions"]:
        if suggestion["id"] == suggestion_id:
            suggestion["isApplied"] = True
            db.resume_analysis["overallAtsScore"] = min(100, db.resume_analysis["overallAtsScore"] + 3)
            return db.resume_analysis
    raise HTTPException(status_code=404, detail="Suggestion not found")

# --- PROJECTS ENDPOINTS ---
@app.get("/api/projects", response_model=List[ProjectRecommendationSchema])
def get_projects():
    return db.projects

@app.post("/api/projects/{project_id}/toggle-save", response_model=ProjectRecommendationSchema)
def toggle_save_project(project_id: str):
    for proj in db.projects:
        if proj["id"] == project_id:
            proj["isSaved"] = not proj["isSaved"]
            return proj
    raise HTTPException(status_code=404, detail="Project not found")

# --- MOCK INTERVIEW ENDPOINTS ---
@app.get("/api/interviews", response_model=List[MockInterviewSessionSchema])
def get_interviews():
    return db.interviews

@app.post("/api/interviews/evaluate", response_model=MockInterviewSessionSchema)
def evaluate_interview_response(data: InterviewEvaluateRequestSchema):
    for session in db.interviews:
        if session["id"] == data.id:
            transcript = data.userTranscript.strip()
            word_count = len(transcript.split())
            
            # Simple AI Scoring Engine heuristic for feedback
            clarity = min(96, max(65, 70 + (word_count // 3)))
            tech_depth = min(98, max(60, 75 + (10 if "attention" in transcript.lower() or "gradient" in transcript.lower() or "overfitting" in transcript.lower() else 0)))
            confidence = min(95, max(65, 72 + (word_count // 4)))
            overall = int((clarity + tech_depth + confidence) / 3)

            feedback = f"Great response! Your transcript showed good technical coverage ({word_count} words). "
            if tech_depth > 80:
                feedback += "Strong domain terminology used. Keep explaining trade-offs clearly!"
            else:
                feedback += "Consider elaborating on edge cases and mathematical trade-offs to boost depth."

            session["userTranscript"] = transcript
            session["overallScore"] = overall
            session["clarityScore"] = clarity
            session["technicalDepthScore"] = tech_depth
            session["confidenceScore"] = confidence
            session["aiFeedback"] = feedback
            return session
    raise HTTPException(status_code=404, detail="Interview session not found")

# --- ANALYTICS ENDPOINTS ---
@app.get("/api/analytics", response_model=List[ProgressMetricSchema])
def get_analytics():
    return db.analytics
