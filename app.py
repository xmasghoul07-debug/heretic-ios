import os
import json
import toml
from typing import Optional
from fastapi import FastAPI, UploadFile, File, HTTPException, Header
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI(title="Heretic AI Backend")

# CORS configuration - allow all origins for development
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# State
active_config = {}

class ChatRequest(BaseModel):
    message: str
    stream: bool = False

@app.get("/")
def health():
    """Health check endpoint"""
    return {
        "status": "online",
        "engine": "Heretic AI v1.0",
        "mode": "production"
    }

@app.post("/api/chat")
async def chat(request: ChatRequest):
    """
    Main chat endpoint. Processes user messages.
    In production, this connects to your Heretic model or OpenAI API.
    """
    user_message = request.message.strip()
    
    if not user_message:
        raise HTTPException(status_code=400, detail="Message cannot be empty")
    
    # Get style modifier from config
    modifier = active_config.get("style", {}).get("modifier", "Direct and thorough")
    
    # Mock response - replace with real model inference
    response = f"[Heretic]: Processing '{user_message[:40]}...' with modifier: {modifier}"
    
    return {"response": response}

@app.post("/api/config/load")
async def load_config(file: UploadFile = File(...)):
    """
    Load TOML configuration files
    """
    global active_config
    
    if not file.filename.endswith('.toml'):
        raise HTTPException(status_code=400, detail="Only .toml files allowed")
    
    try:
        content = await file.read()
        parsed = toml.loads(content.decode("utf-8"))
        active_config = parsed
        return {
            "status": "success",
            "file": file.filename,
            "keys": list(parsed.keys())
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Parse error: {str(e)}")

@app.get("/api/status")
def status():
    """Get current system status"""
    return {
        "connected": True,
        "config_loaded": bool(active_config),
        "config_keys": list(active_config.keys()) if active_config else []
    }

if __name__ == "__main__":
    import uvicorn
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port, log_level="info")
