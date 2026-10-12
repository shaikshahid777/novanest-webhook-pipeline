# NovaNest Webhook Call Log Pipeline (Retell AI - Topic 8)

Event-driven pipeline: Retell `call_analyzed` webhook -> n8n -> Google Sheet call log (one row per call, no duplicates).

## Architecture
Webhook (200 OK immediately) -> Is `call_analyzed`? -> Has `call_id`? -> Lookup `call_id` in Sheet -> Duplicate? -> Map & Transform -> Append Row (retry x3)

- `call_started` / `call_ended` / other events: acknowledged and discarded
- Missing `call_id`: Stop and Error (visible in failed executions)
- Duplicate `call_id`: "duplicate skipped" path, nothing written

## Repo layout
- `workflow/novanest-call-log.json` - import into n8n
- `sheet-headers.csv` - 12 column headers for the Google Sheet (tab name: `NovaNest Call Log`)
- `tests/payloads/` - test payloads; `tests/run_tests.ps1` (Windows PowerShell) and `tests/run_tests.sh` (bash) - curl test runners
- `docs/` - field mapping, test results, demo script

## Setup
1. Create a Google Sheet, tab `NovaNest Call Log`, paste headers from `sheet-headers.csv` in row 1.
2. n8n: Workflows -> Import from file -> `workflow/novanest-call-log.json`.
3. In both Google Sheets nodes: select your credential, set the Sheet ID.
4. Activate the workflow; copy the **Production** webhook URL (must be public HTTPS).
5. Retell dashboard -> NovaNest agent -> Webhook URL (agent-level) -> paste URL.
6. Run `WEBHOOK_URL=<url> ./tests/run_tests.sh`, then a real test call.
7. (Recommended) n8n Settings -> Error Workflow: send failures to email/Slack.

## Webhook registration evidence
Agent-level webhook URL and the three subscribed events (call_started, call_ended, call_analyzed) are shown in `docs/screenshots/17-*.png` and `18-*.png`.

## Testing
- 1 full end-to-end real Retell call, plus payload-injection tests (curl.exe) covering Warm and Disqualified leads, duplicate delivery, missing call_analysis (N/A), invalid recording URL ("URL expired"), missing call_id (failed execution) and discarded events.
- Additional real calls were skipped to save call credits.
- Results: `docs/test-results.md`; screenshots: `docs/screenshots/`.
- Demo video: https://www.loom.com/share/75985b0632364804840d82b19f987200

## Assumptions
- Post-Call Analysis (Topics 5-6) already outputs caller fields and `qualification_status`.
- Times shown in America/Chicago (CT).

## Limitations
- Recording URL is only validated, not re-uploaded; permanent storage would need an extra download+upload step within 10 minutes.
- Lookup+append is not atomic; two simultaneous identical deliveries could still race.
- Rapid concurrent deliveries within a few seconds can overwrite rows in Google Sheets (seen in a curl burst test); real calls arrive minutes apart.
- In the real call, the Topic 7 create_booking_request function returned an error. This does not affect the webhook pipeline, which still logged the call correctly.

## Enhancements
- Upload recording to Drive/S3 immediately; store permanent link
- Verify Retell webhook signature header
- Slack alert for Hot leads; dead-letter tab in the sheet
