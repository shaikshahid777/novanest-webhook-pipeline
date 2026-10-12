# Webhook Field Mapping (call_analyzed is the source of record)

| Destination column | JSON path | Transformation |
|---|---|---|
| call_id | call.call_id | Idempotency key; checked before write |
| call_date | call.start_timestamp | ms epoch -> YYYY-MM-DD (America/Chicago) |
| call_time | call.start_timestamp | ms epoch -> HH:MM CT |
| duration_seconds | call.duration_ms | / 1000, rounded |
| call_status | call.call_status | none |
| caller_name | call.call_analysis.caller_first_name + caller_last_name | space-concatenate |
| caller_phone | call.call_analysis.caller_phone | N/A if null |
| caller_email | call.call_analysis.caller_email | N/A if null |
| qualification_status | call.call_analysis.qualification_status | Hot/Warm/Cold/Disqualified, N/A if null |
| call_summary | call.call_analysis.call_summary | N/A if null |
| recording_url | call.recording_url | valid https URL kept; otherwise "URL expired" |
| follow_up_status | (default) | always "Pending" |

## Event routing
| Event | Action |
|---|---|
| call_started | Discard (200, no write) |
| call_ended | Discard (200, no write) |
| call_analyzed | Check call_id exists -> dedupe -> map -> append |
| other | 200, no write |

## Error handling
| Failure | Behaviour |
|---|---|
| Missing call.call_id | Stop and Error node -> appears in n8n Executions (failed) |
| call_analysis null/missing | Row written, columns = "N/A" |
| Sheet write fails | Retry on fail, 3 tries total (2 retries), then failed execution |
| Recording URL expired/invalid | "URL expired" placeholder |
