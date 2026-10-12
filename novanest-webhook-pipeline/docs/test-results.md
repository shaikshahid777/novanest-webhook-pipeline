# Test Results

Method: 1 full end-to-end real Retell web call, plus payload-injection tests using PowerShell `curl.exe` (payloads in `tests/payloads/`). Additional real calls were skipped to save call credits. Screenshots are in `docs/screenshots/`.

| TC | Description | Result | Evidence |
|---|---|---|---|
| TC-001 | call_analyzed creates a row | Pass | Real call (Mia Torres, Hot) produced the row (screenshots 09, 10, 13) |
| TC-002 | call_started / call_ended discarded | Pass | Real call: both events took the "Discarded (other event)" path, no row; also tested by payload (screenshots 11, 12) |
| TC-003 | Duplicate prevention | Pass | Same payload sent twice; second execution took "duplicate skipped", no new row (screenshots 03, 04) |
| TC-004 | Field mapping accuracy | Pass | Real call execution output and sheet row compared column by column (date, time, duration, name, status) (screenshot 10) |
| TC-005 | Recording URL expiry | Pass | Empty recording_url produced "URL expired" (screenshot 08) |
| TC-006 | Missing call_analysis gives N/A | Pass | Payload without call_analysis produced N/A in caller and summary columns (screenshot 08) |
| TC-007 | 200 OK response speed | Pass | All deliveries acknowledged in about 1-4 seconds, under 10 s (screenshot 07) |
| TC-008 | Distinct rows per call | Pass | Rows for Mia Torres (real call), Ravi Kumar (Warm) and Sara Lee (Disqualified) via payload injection, each with a unique call_id (screenshot 08) |
| TC-009 | follow_up_status = Pending | Pass | "Pending" on every row (screenshots 08, 13) |
| TC-010 | Failed execution visible | Pass | Missing call_id produced a red failed execution: "Payload missing call.call_id - row not written" (screenshot 06) |
