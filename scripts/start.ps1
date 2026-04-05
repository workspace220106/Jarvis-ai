$base = "C:\Users\araji\jarvis-ai"

Write-Host "==============================" -ForegroundColor Cyan
Write-Host "  JARVIS-AI STARTING" -ForegroundColor White
Write-Host "  100% FREE — FULLY LOCAL" -ForegroundColor Green
Write-Host "==============================" -ForegroundColor Cyan

Write-Host "[1/3] Ollama..." -ForegroundColor Blue
Stop-Process -Name "ollama" -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1
Start-Process "ollama" -ArgumentList "serve" -WindowStyle Hidden
Start-Sleep -Seconds 4

Write-Host "[2/3] LiteLLM router..." -ForegroundColor Blue
Start-Process "$base\litellm\env\Scripts\litellm" `
  -ArgumentList "--config $base\configs\litellm_config.yaml --port 4000" `
  -WindowStyle Hidden
Start-Sleep -Seconds 4

Write-Host "[3/3] OpenClaw gateway..." -ForegroundColor Blue
Start-Process "powershell" `
  -ArgumentList "-NoExit -Command openclaw gateway" `
  -WindowStyle Normal
Start-Sleep -Seconds 4

Write-Host ""
try { Invoke-RestMethod http://localhost:11434/api/tags | Out-Null
  Write-Host "  Ollama    OK  :11434" -ForegroundColor Green
} catch { Write-Host "  Ollama    FAIL" -ForegroundColor Red }

try { Invoke-RestMethod http://localhost:4000/v1/models -Headers @{Authorization="Bearer local-dev-key"} | Out-Null
  Write-Host "  LiteLLM   OK  :4000" -ForegroundColor Green
} catch { Write-Host "  LiteLLM   FAIL" -ForegroundColor Red }

try { Invoke-WebRequest http://127.0.0.1:18791/ -UseBasicParsing | Out-Null
  Write-Host "  OpenClaw  OK  :18791" -ForegroundColor Green
} catch { Write-Host "  OpenClaw  starting..." -ForegroundColor Yellow }

Write-Host ""
Write-Host "==============================" -ForegroundColor Cyan
Write-Host "  READY — ALL FREE LOCAL AI" -ForegroundColor Green
Write-Host "==============================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Aider   -> cd your-project && aider" -ForegroundColor White
Write-Host "  VS Code -> Ctrl+L for Continue chat" -ForegroundColor White
Write-Host "  Flowise -> .\scripts\start-flowise.ps1" -ForegroundColor White
Write-Host "  OpenClaw-> http://127.0.0.1:18791" -ForegroundColor White
