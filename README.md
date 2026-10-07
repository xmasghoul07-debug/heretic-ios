# Heretic AI - Auto-Configuring iPhone App

A complete Heretic AI browser chatbot that **auto-detects and configures itself**. No manual setup needed.

## Key Features

✓ **Auto-configuration** - detects backend automatically  
✓ **Works on iPhone** - Safari + home screen app  
✓ **Demo mode** - works without backend  
✓ **Deploys anywhere** - Netlify (frontend) + Render (backend)  
✓ **Terminal UI** - clean monospace interface  
✓ **Expandable** - easy to add real LLM  

## How It Works

1. Open the app on iPhone
2. It auto-detects your backend or runs in demo mode
3. Start typing and chatting
4. No configuration needed

## Deployment (5 minutes)

### Step 1: Deploy Backend (Render)

1. Go to [render.com](https://render.com)
2. Click "New +" → "Web Service"
3. Connect your GitHub repo
4. Set:
   - Build command: `pip install -r backend/requirements.txt`
   - Start command: `cd backend && uvicorn app:app --host 0.0.0.0 --port $PORT`
5. Deploy
6. Copy your URL (e.g., `https://heretic-ai-backend-xxxxx.onrender.com`)

### Step 2: Deploy Frontend (Netlify)

1. Go to [netlify.com](https://netlify.com)
2. Drag and drop the repo or connect GitHub
3. Set:
   - Build command: (leave blank)
   - Publish directory: `.` (root)
4. Deploy
5. Get your Netlify URL

### Step 3: Update Frontend (if needed)

In `index.html`, line ~115, update:
```javascript
return `https://your-backend-url.onrender.com`;
```

### Step 4: Open on iPhone

1. Open Safari
2. Go to your Netlify URL
3. Tap Share → Add to Home Screen
4. Opens like an app!

## Local Testing

### Terminal 1: Backend
```bash
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --host 0.0.0.0 --port 8000 --reload
```

### Terminal 2: Frontend
```bash
python3 -m http.server 8000
# or just open index.html in a browser
```

Then visit: `http://localhost:8000`

## API Endpoints

### `GET /`
Health check

### `POST /api/chat`
Send a message
```json
{
  "message": "What is Heretic?",
  "stream": false
}
```

### `POST /api/config/load`
Upload TOML config

### `GET /api/status`
Get system status

## Environment Detection

The app auto-detects:
- **localhost** → uses `http://localhost:8000`
- **Netlify domain** → uses backend route `/api`
- **Production** → uses environment variable or stored URL

## Next Steps

1. **Add real LLM**: Replace mock responses in `backend/app.py` with OpenAI/Anthropic/local model
2. **Add streaming**: Enable real-time response streaming
3. **Add auth**: Add API key validation
4. **Add persistence**: Save chat history to database

## Troubleshooting

**App shows "OFFLINE"**
- Check backend URL in `index.html`
- Verify backend is running
- Check CORS settings

**App stuck on "Configuring"**
- Hard refresh Safari (AA button → Settings → Clear History)
- Try demo mode (click settings icon)

**Backend errors**
- Check logs: `heroku logs -t`
- Verify `.toml` files are valid

## License

AGPL-3.0 (same as Heretic)
