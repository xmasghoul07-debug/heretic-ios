# backend

This directory contains a minimal FastAPI service that should sit behind the iPhone app.

## Setup

```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --host 0.0.0.0 --port 8000 --reload
```

## Endpoint

POST `/chat`

Request body:

```json
{
  "message": "Hello",
  "conversation_id": "demo"
}
```

Response:

```json
{
  "reply": "Hello! I'm your Heretic-style AI assistant.",
  "conversation_id": "demo"
}
```

To connect to a real model, replace `generate_reply()` in `app.py` with your model inference logic.
