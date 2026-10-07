# HereticAI

This is a starter SwiftUI app for an iPhone chat assistant inspired by the Heretic-style uncensored model workflow.

## Requirements

- Xcode 15+
- iOS 17+
- A running backend on `http://127.0.0.1:8000`

## Start backend

```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --host 0.0.0.0 --port 8000 --reload
```

## Open in Xcode

1. Open `ios/HereticAI/HereticAIApp.swift` in Xcode.
2. Create a new iOS app target if needed.
3. Add the files in `ios/HereticAI/` to the app target.
4. Run on a simulator or connected device.

## Notes

- The app is wired to the local backend by default.
- Replace the mock reply logic in `backend/app.py` to connect to a real model.
- This is a foundation, not a full production model-stack.
