#!/usr/bin/env bash
# Usage: WEBHOOK_URL="https://<your-n8n>/webhook/retell-novanest" ./tests/run_tests.sh
set -u
: "${WEBHOOK_URL:?Set WEBHOOK_URL first}"
D="$(dirname "$0")/payloads"
send(){ curl -s -o /dev/null -w "  -> HTTP %{http_code} in %{time_total}s\n" -X POST "$WEBHOOK_URL" -H "Content-Type: application/json" -d @"$1"; }

echo "TC-001/009 valid Hot call (expect new row, follow_up_status=Pending)"; send $D/01_valid_call_analyzed.json
echo "TC-002 call_started / call_ended (expect NO row)"; send $D/06_call_started.json; send $D/07_call_ended.json
echo "TC-003 duplicate: same payload again (expect 'duplicate skipped', no 2nd row)"; sleep 5; send $D/01_valid_call_analyzed.json
echo "TC-005 bad recording url (expect 'URL expired')"; send $D/05_bad_recording_url.json
echo "TC-006 missing call_analysis (expect N/A columns)"; send $D/04_missing_call_analysis.json
echo "TC-007 response time: every call above must be < 10s (shown in output)"
echo "TC-008 three distinct rows"; send $D/02_valid_warm.json; send $D/03_valid_disqualified.json
echo "Extra: missing call_id (expect FAILED execution in n8n Executions)"; send $D/08_missing_call_id.json
