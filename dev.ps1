param(
    [Parameter(Position = 0)]
    [string]$Task = "help"
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

function Write-Header {
    param([string]$Message)
    Write-Host "`n=== $Message ===" -ForegroundColor Cyan
}

function Invoke-CommandChecked {
    param([string]$Command)
    Write-Host $Command -ForegroundColor Gray
    Invoke-Expression $Command
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed with exit code $LASTEXITCODE"
    }
}

Set-Location $repoRoot

switch ($Task) {
    "bootstrap" {
        Write-Header "Restoring tools"
        Invoke-CommandChecked "dotnet tool restore"
        Write-Header "Restoring packages"
        Invoke-CommandChecked "dotnet restore"
    }
    "format" {
        Write-Header "Formatting code"
        Invoke-CommandChecked "dotnet format ActivityMemory.sln"
    }
    "format:check" {
        Write-Header "Checking format"
        Invoke-CommandChecked "dotnet format ActivityMemory.sln --verify-no-changes --no-restore"
    }
    "build" {
        Write-Header "Building solution"
        Invoke-CommandChecked "dotnet build ActivityMemory.sln"
    }
    "test" {
        Write-Header "Running tests"
        Invoke-CommandChecked "dotnet test ActivityMemory.sln --no-build"
    }
    "check" {
        Write-Header "Checking format"
        Invoke-CommandChecked "dotnet format ActivityMemory.sln --verify-no-changes --no-restore"
        Write-Header "Building solution"
        Invoke-CommandChecked "dotnet build ActivityMemory.sln"
        Write-Header "Running tests"
        Invoke-CommandChecked "dotnet test ActivityMemory.sln --no-build"
    }
    "run" {
        Write-Header "Running app"
        Invoke-CommandChecked "dotnet run --project src/ActivityMemory.App/ActivityMemory.App.csproj"
    }
    "clean" {
        Write-Header "Cleaning solution"
        Invoke-CommandChecked "dotnet clean ActivityMemory.sln"
    }
    "help" {
        Write-Host "Usage: .\\dev.ps1 <task>" -ForegroundColor Yellow
        Write-Host "" 
        Write-Host "Tasks:" -ForegroundColor Yellow
        Write-Host "  bootstrap     Restore tools and packages"
        Write-Host "  format        Apply formatting"
        Write-Host "  format:check  Verify formatting"
        Write-Host "  build         Build the solution"
        Write-Host "  test          Run tests"
        Write-Host "  check         format:check + build + test"
        Write-Host "  run           Run the WPF app"
        Write-Host "  clean         Clean build outputs"
        Write-Host "  help          Show this help"
    }
    default {
        Write-Host "Unknown task '$Task'. Use .\\dev.ps1 help" -ForegroundColor Red
        exit 1
    }
}
