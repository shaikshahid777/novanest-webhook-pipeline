# Demo Video Script (5-7 min, Loom/YouTube)

1. (0:00) Intro: NovaNest Webhook Call Log Pipeline, what it solves.
2. (0:30) Retell dashboard -> NovaNest agent -> Webhook setting: show agent-level HTTPS URL from n8n.
3. (1:15) n8n workflow walkthrough: Webhook (200 immediately) -> event filter -> call_id check -> sheet lookup (idempotency) -> Code node (mapping) -> Append (retry 3) .
4. (2:30) Show Google Sheet with 12 headers (empty).
5. (3:00) Run a real test call in Retell test console; show call_started/call_ended executions discarded, call_analyzed creates row in <60s.
6. (4:00) Run `tests/run_tests.sh`: duplicate skipped, N/A defaults, URL expired, response time < 10s.
7. (5:00) Show failed execution visibility (missing call_id, or revoke sheet access).
8. (5:45) Assumptions, limitations, enhancements. Show GitHub repo.
