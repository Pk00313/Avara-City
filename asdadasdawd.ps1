$inputFile1 = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt')

$host.ui.RawUI.WindowTitle = "CHH Viewer - Made by Pk00 & Sedin"
Clear-Host
Write-Host ""
Write-Host -ForegroundColor Magenta @"
  _____                              _________ .__  __          
  /  _  \___  _______ ____________    \_   ___ \|__|/  |_ ___.__.
 /  /_\  \  \/ /\__  \\_  __ \__  \   /    \  \/|  \   __<   |  |
/    |    \   /  / __ \|  | \// __ \_ \     \___|  ||  |  \___  |
\____|__  /\_/  (____  /__|  (____  /  \______  /__||__|  / ____|
        \/           \/           \/          \/          \/      
"@

Write-Host -ForegroundColor White "        Made by Pk00 & Sedin - " -NoNewLine
Write-Host -ForegroundColor White "discord.gg/avara"
Write-Host ""

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if (-not (Test-Admin)) {
    Write-Warning " Bitte führen Sie dieses Skript als Administrator aus."
    Start-Sleep 10
    Exit
}

try {
    $data1 = Get-Content -Path $inputFile1 -ErrorAction Stop
    if ($data1) {
        Write-Host "`n[ConsoleHost History] $($data1.Count) Einträge geladen." -ForegroundColor Cyan
        $data1 | Out-GridView -Title "ConsoleHost History - $env:USERNAME"
    } else {
        Write-Host "Keine Daten in ConsoleHost History gefunden." -ForegroundColor Yellow
    }
} catch {
    Write-Host -ForegroundColor Red "Fehler beim Lesen der ConsoleHost-Datei: $_"
}

# 🛑 Verhindert, dass das Fenster sofort geschlossen wird
Write-Host "`nDrücken Sie eine beliebige Taste zum Beenden..."
[void][System.Console]::ReadKey($true)
