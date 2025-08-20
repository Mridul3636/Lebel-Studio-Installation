# -------------------------------
# One-Click Setup: Python + Label Studio
# -------------------------------

# -------------------------------
# Step 0: Ensure running as Admin
# -------------------------------
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Not running as Administrator. Relaunching..."
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}
Else
{
    Write-Host "✅ Running as Administrator!" -ForegroundColor Green
}

# -------------------------------
# Step 1: Download & Install Python
# -------------------------------
$pythonUrl = "https://www.python.org/ftp/python/3.12.2/python-3.12.2-amd64.exe"
$installerPath = "$env:TEMP\python_installer.exe"

Write-Host "📥 Downloading Python..."
Invoke-WebRequest -Uri $pythonUrl -OutFile $installerPath

Write-Host "⚙️ Installing Python..."
Start-Process -FilePath $installerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 Include_pip=1" -Wait

# -------------------------------
# Step 2: Verify Python & Upgrade pip
# -------------------------------
try {
    $pythonVersion = & python --version
    Write-Host "✅ Python Installed: $pythonVersion"
    Write-Host "🔧 Upgrading pip..."
    python -m pip install --upgrade pip
} catch {
    Write-Host "❌ Python installation failed or PATH not set correctly!" -ForegroundColor Red
    exit
}

# -------------------------------
# Step 3: Install Label Studio
# -------------------------------
Write-Host "📦 Installing Label Studio..."
python -m pip install --upgrade label-studio

# -------------------------------
# Step 4: Run Label Studio
# -------------------------------
Write-Host "🚀 Launching Label Studio..."
Start-Process -FilePath "label-studio" 

Write-Host "`n✅ Setup Completed!"
Write-Host "Open your browser at http://localhost:8080 to start labeling."
pause


Developed by Md. Minhazur Rahaman