# Screenshots (evidence)

| # | File | What it shows | Test case |
|---|---|---|---|
| 01 | 01-n8n-workflow-canvas.png | Full workflow: Webhook, filters, Lookup, Duplicate?, Map & Transform, Append Row | Architecture |
| 02 | 02-first-test-execution-success.png | First test execution, green end to end | TC-001 |
| 03 | 03-duplicate-test-powershell.png | Same payload sent twice with curl.exe | TC-003 |
| 04 | 04-duplicate-skipped-execution.png | Second delivery routed to "duplicate skipped" | TC-003 |
| 05 | 05-payload-tests-powershell.png | All payload tests sent from PowerShell | TC-002 to TC-010 |
| 06 | 06-failed-execution-missing-call-id.png | Red failed execution: "Payload missing call.call_id - row not written" | TC-010 |
| 07 | 07-executions-list-payload-tests.png | Executions list from the payload tests (fast responses, one red error) | TC-007, TC-010 |
| 08 | 08-google-sheet-all-test-cases.png | Sheet with N/A row, "URL expired" row, Warm and Disqualified rows, Pending | TC-005, TC-006, TC-008, TC-009 |
| 09 | 09-real-call-execution-success.png | call_analyzed execution from the real Retell call, green through Append Row | TC-001 |
| 10 | 10-real-call-append-row-output.png | Mapped output of the real call (name, phone, email, Hot, summary, Pending) | TC-004 |
| 11 | 11-real-call-call_started-discarded.png | call_started took the "Discarded (other event)" path | TC-002 |
| 12 | 12-real-call-call_ended-discarded.png | call_ended took the "Discarded (other event)" path | TC-002 |
| 13 | 13-google-sheet-with-real-call-row.png | Sheet including the row created by the real call | TC-001 |
| 14 | 14-retell-call-custom-analysis-and-transcript.png | Retell call history: custom analysis fields and transcript | TC-001 |
| 15 | 15-append-row-retry-settings.png | Append Row: Retry On Fail, 3 tries | Retry strategy |
| 16 | 16-lookup-always-output-data.png | Lookup node: Always Output Data (needed for the duplicate check) | TC-003 |
| 17 | 17-retell-agent-level-webhook-url.png | Retell agent settings: Agent Level Webhook URL (n8n production webhook), 5 s timeout | Webhook registration |
| 18 | 18-retell-webhook-events.png | Webhook Events: Call started, Call ended, Call analyzed enabled | Webhook registration |
