# Heretic iPhone

A starter iPhone app and backend for a Heretic-style uncensored AI chat experience.

This repo contains:
- `backend/` — FastAPI server that exposes a chat endpoint
- `ios/` — SwiftUI iPhone app shell that sends messages and displays replies

It is intentionally a working MVP scaffold, not a full production model wrapper. The backend currently uses a mock reply generator so the app works immediately, and you can swap in your actual uncensored model client later.

## Architecture

- iPhone app: SwiftUI chat UI
- API: FastAPI backend
- Model integration point: `backend/app.py` -> `generate_reply()`
- Transport: JSON over HTTP

## Quick start

### 1) Start the backend

```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --host 0.0.0.0 --port 8000 --reload
```

### 2) Open the iPhone app in Xcode

Open the folder `ios/HereticAI` as a SwiftUI app project or copy the source files into a new Xcode app target.

Update the API base URL in `ios/HereticAI/ChatService.swift` if needed.

### 3) Build and run

- Device or simulator: iPhone 15 / iOS 17+
- Xcode 15+

## Project files

- `backend/app.py` — FastAPI chat API
- `backend/requirements.txt` — backend dependencies
- `ios/HereticAI/HereticAIApp.swift` — app entry point
- `ios/HereticAI/ContentView.swift` — chat UI
- `ios/HereticAI/ChatViewModel.swift` — app state and message sending
- `ios/HereticAI/ChatService.swift` — API client
- `ios/HereticAI/Models.swift` — data structures

## Next steps

- Replace the mock reply generator with an actual Heretic model client
- Add conversation persistence
- Add streaming responses for a more native chat feel
- Add settings for temperature, context window, and model selection
- Add voice input and image support if desired

