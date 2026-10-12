# PowerShell test runner (Windows). Run from the repo root:
#   $env:WEBHOOK_URL = "https://<your-n8n>/webhook/retell-novanest"
#   .\tests\run_tests.ps1
if (-not $env:WEBHOOK_URL) { Write-Host "Set `$env:WEBHOOK_URL first"; exit 1 }
$d = Join-Path $PSScriptRoot "payloads"
function Send($f) { curl.exe -s -o NUL -w "  -> HTTP %{http_code} in %{time_total}s`n" -X POST $env:WEBHOOK_URL -H "Content-Type: application/json" -d "@$d\$f" }

Write-Host "TC-001 valid call_analyzed (new row)";           Send "01_valid_call_analyzed.json"
Write-Host "TC-002 call_started / call_ended (no row)";      Send "06_call_started.json"; Send "07_call_ended.json"
Write-Host "TC-003 duplicate (skipped)";                     Start-Sleep 6; Send "01_valid_call_analyzed.json"
Write-Host "TC-006 missing call_analysis (N/A)";             Start-Sleep 6; Send "04_missing_call_analysis.json"
Write-Host "TC-005 bad recording url (URL expired)";         Start-Sleep 6; Send "05_bad_recording_url.json"
Write-Host "TC-008 Warm and Disqualified rows";              Start-Sleep 6; Send "02_valid_warm.json"; Start-Sleep 6; Send "03_valid_disqualified.json"
Write-Host "TC-010 missing call_id (failed execution)";      Start-Sleep 6; Send "08_missing_call_id.json"
Write-Host "TC-007: every request above must answer in < 10 s"
