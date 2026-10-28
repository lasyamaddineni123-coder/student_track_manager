Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "Starting Student Task and Assignment Tracker MVP..." -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan

$env:Path = "$env:LOCALAPPDATA\Programs\nodejs;$env:Path"

Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd backend; npm start"
Start-Sleep -Seconds 2
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd frontend; npm run dev"

Write-Host "Backend running on http://localhost:5000" -ForegroundColor Green
Write-Host "Frontend running on http://localhost:3000" -ForegroundColor Green
