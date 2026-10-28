@echo off
echo ===================================================
echo Starting Student Task and Assignment Tracker MVP...
echo ===================================================

set PATH=%LOCALAPPDATA%\Programs\nodejs;%PATH%

start "StudyTrack Backend" cmd /k "cd backend && npm start"
timeout /t 2 /nobreak > nul
start "StudyTrack Frontend" cmd /k "cd frontend && npm run dev"

echo Backend running on http://localhost:5000
echo Frontend starting on http://localhost:3000
pause
