Set-Location "C:\Users\araji\jarvis-ai\flowise"
$env:PORT = "3000"
$env:FLOWISE_USERNAME = "admin"
$env:FLOWISE_PASSWORD = "jarvis123"
.\node_modules\.bin\flowise start --port=3000 --host=0.0.0.0
