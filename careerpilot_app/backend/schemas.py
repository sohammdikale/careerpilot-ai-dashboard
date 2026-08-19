from pydantic import BaseModel
from typing import List, Optional

class UserProfileSchema(BaseModel):
    name: str
    title: str
    targetRole: str
    bio: str
    email: str
    location: str
    readinessScore: int
    avatarUrl: str
    completedMilestones: int
    totalMilestones: int

class UserProfileUpdateSchema(BaseModel):
    name: str
    title: str
    targetRole: str
    bio: str
    location: str

class SkillItemSchema(BaseModel):
    id: str
    name: str
    category: str
    proficiency: float
    status: str
    isTargetRequired: bool = False

class SkillCreateSchema(BaseModel):
    name: str
    category: str
    proficiency: float = 0.5
    isTargetRequired: bool = False

class SkillUpdateProficiencySchema(BaseModel):
    proficiency: float

class RoadmapMilestoneSchema(BaseModel):
    id: str
    title: str
    phase: str
    description: str
    isCompleted: bool
    duration: str
    skillsCovered: List[str]

class ResumeSuggestionSchema(BaseModel):
    id: str
    section: str
    title: str
    description: str
    impactLevel: str
    isApplied: bool = False

class ResumeAnalysisSchema(BaseModel):
    overallAtsScore: int
    impactScore: int
    keywordMatchScore: int
    formatScore: int
    structureScore: int
    suggestions: List[ResumeSuggestionSchema]

class ProjectRecommendationSchema(BaseModel):
    id: str
    title: str
    domain: str
    difficulty: str
    description: str
    tags: List[str]
    matchPercentage: int
    estimatedDuration: str
    isSaved: bool = False
    isStarted: bool = False

class MockInterviewSessionSchema(BaseModel):
    id: str
    question: str
    category: str
    difficulty: str
    userAudioPath: Optional[str] = None
    userTranscript: Optional[str] = None
    overallScore: Optional[int] = None
    clarityScore: Optional[int] = None
    technicalDepthScore: Optional[int] = None
    confidenceScore: Optional[int] = None
    aiFeedback: Optional[str] = None

class InterviewEvaluateRequestSchema(BaseModel):
    id: str
    userTranscript: str

class ProgressMetricSchema(BaseModel):
    day: str
    skillScore: float
    interviewScore: float
    readinessScore: float

class ApiResponseSchema(BaseModel):
    success: bool
    message: str
    data: Optional[dict] = None
