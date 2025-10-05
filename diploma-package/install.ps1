# PowerShell installer for diploma project
Write-Host "Setting up diploma project environment..."

# 1) Ensure Node.js 18+ is available
$node = node -v 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Host "Node.js not found. Please install Node 18+ and re-run." -ForegroundColor Red
  exit 1
}

# 2) Install dependencies
Write-Host "Installing dependencies (npm ci)..."
npm ci

# 3) Build the project
Write-Host "Building project (npm run build)..."
npm run build

# 4) Simple verification (show CSP header and small HTML excerpt)
if (Get-Command curl -ErrorAction SilentlyContinue) {
  curl -i "http://localhost:3000" -UseBasicParsing
} else {
  Write-Host "curl not found; use browser to inspect HTTP headers after running 'npm start'" -ForegroundColor Yellow
}

Write-Host "Setup complete." -ForegroundColor Green
