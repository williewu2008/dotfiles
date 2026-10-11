param(
    [Parameter(Mandatory=$true)]
    [string]$Text,
    [string]$Voice = "zh-TW-YunJheNeural"
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$pythonScript = Join-Path $scriptDir "speak.py"
$tempAudio = Join-Path $env:TEMP "agy_speech_$(Get-Random).mp3"

$pythonExe = "python.exe"
if (Test-Path ".\.venv\Scripts\python.exe") {
    $pythonExe = (Resolve-Path ".\.venv\Scripts\python.exe").Path
} elseif (Test-Path "E:\用Agent來學習Agent\.venv\Scripts\python.exe") {
    $pythonExe = "E:\用Agent來學習Agent\.venv\Scripts\python.exe"
}

& $pythonExe $pythonScript --text "$Text" --voice "$Voice" --output "$tempAudio"

if (-not (Test-Path $tempAudio)) {
    Write-Error "語音生成失敗"
    exit 1
}

Add-Type -AssemblyName PresentationCore
$player = New-Object System.Windows.Media.MediaPlayer
$player.Open([System.Uri]::new([System.IO.Path]::GetFullPath($tempAudio)))

$timeout = 0
while ((-not $player.NaturalDuration.HasTimeSpan) -and ($timeout -lt 50)) {
    Start-Sleep -Milliseconds 100
    $timeout++
}

$player.Play()

if ($player.NaturalDuration.HasTimeSpan) {
    $durationMs = [int]$player.NaturalDuration.TimeSpan.TotalMilliseconds
    Start-Sleep -Milliseconds ($durationMs + 400)
}
if (-not $player.NaturalDuration.HasTimeSpan) {
    Start-Sleep -Seconds 6
}

$player.Close()

if (Test-Path $tempAudio) {
    Remove-Item -Force $tempAudio -ErrorAction SilentlyContinue
}

Write-Output "語音播放完成"