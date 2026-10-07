from __future__ import annotations

from fastapi import FastAPI
from pydantic import BaseModel, Field

app = FastAPI(title="Heretic AI API", version="0.1.0")


class ChatRequest(BaseModel):
    message: str = Field(..., min_length=1)
    conversation_id: str | None = None


class ChatResponse(BaseModel):
    reply: str
    conversation_id: str


def generate_reply(prompt: str) -> str:
    """Replace this with your model runtime or API client."""
    text = prompt.strip()
    lowered = text.lower()

    if not text:
        return "Please send a message."
    if "hello" in lowered or "hi" in lowered:
        return "Hello! I'm your Heretic-style AI assistant. Ask me anything."
    if "time" in lowered:
        return "I don't have a real clock in this demo, but the backend is running correctly."
    if "name" in lowered:
        return "I'm a demo Heretic-inspired AI assistant running on this server."

    return (
        "This is a working starter backend for a Heretic-style chat app. "
        "Swap out the mock generator in `generate_reply()` for your actual model inference."
    )


@app.get("/health")
async def health() -> dict[str, str]:
    return {"status": "ok"}


@app.post("/chat", response_model=ChatResponse)
async def chat(request: ChatRequest) -> ChatResponse:
    conversation_id = request.conversation_id or "demo-conversation"
    reply = generate_reply(request.message)
    return ChatResponse(reply=reply, conversation_id=conversation_id)


if __name__ == "__main__":
    import uvicorn

    uvicorn.run("app:app", host="0.0.0.0", port=8000, reload=True)
