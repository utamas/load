#!/usr/bin/env bash

WARMUP_ROUNDS=3
MEASUREMENT_ROUNDS=10

PARALLEL_USER_COUNT=${PARALLEL_USER_COUNT:-100}
NUMBER_OF_REQUEST_IN_TOTAL=${NUMBER_OF_REQUEST_IN_TOTAL:-10000}

MOCK_BASE_URL=http://localhost:9999
# Ticket
MOCK_TICKET_PATH=/api/v2/tickets/34677
MOCK_TICKET_REQUEST=ticket/status.json
# Reply
MOCK_REPLY_PATH=/api/v2/tickets/34677/reply
MOCK_REPLY_REQUEST=reply/fd-reply.json

SERVICE_BASE_URL=http://localhost:8080
# Ticket
SERVICE_TICKET_PATH=/api/status/34677/waiting_on_developer
# Reply
SERVICE_REPLY_PATH=/api/message/34677
SERVICE_REPLY_REQUEST=reply/fd-int-reply.json
