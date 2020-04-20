#!/usr/bin/env bash

if [[ "${VERBOSE}" == "true" ]]; then
  set -x
fi

set -eup pipefail

source ./config.sh

rm ticket/measurements/service_*
rm ticket/measurements/mock_*
for i in `seq ${WARMUP_ROUNDS}`; do
  echo "Ticket/Mock - Warmup round #${i}"
  ab -k -c 10 \
     -n 1000 \
     -u ${MOCK_TICKET_REQUEST} -T application/json \
     ${MOCK_BASE_URL}${MOCK_TICKET_PATH}
done
echo "Ticket/mock - measure mock to get a baseline"
for i in `seq ${MEASUREMENT_ROUNDS}`; do
  ab -k -c ${PARALLEL_USER_COUNT} \
        -n ${NUMBER_OF_REQUEST_IN_TOTAL} \
        -u ${MOCK_TICKET_REQUEST} -T application/json \
        -e ticket/measurements/mock_${i}.csv \
        ${MOCK_BASE_URL}${MOCK_TICKET_PATH} > ticket/measurements/mock-${i}
done

for i in `seq ${WARMUP_ROUNDS}`; do
  echo "Ticket/Service - Warmup round #${i}"
  ab -k -c 10 \
     -n 1000 \
     -u ${SERVICE_TICKET_REQUEST} -T application/json \
     ${SERVICE_BASE_URL}${SERVICE_TICKET_PATH}
done
echo "Ticket/service - measure"
for i in `seq ${MEASUREMENT_ROUNDS}`; do
  ab -k -c ${PARALLEL_USER_COUNT} \
        -n ${NUMBER_OF_REQUEST_IN_TOTAL} \
        -u ${SERVICE_TICKET_REQUEST} -T application/json \
        -e ticket/measurements/service_${i}.csv \
        ${SERVICE_BASE_URL}${SERVICE_TICKET_PATH} > ticket/measurements/service_${i}
done





rm reply/measurements/service_* || true
rm reply/measurements/mock_* || true
for i in `seq ${WARMUP_ROUNDS}`; do
  echo "Reply/Mock - Warmup round #${i}"
  ab -k -c 10 \
     -n 1000 \
     -u ${MOCK_TICKET_REQUEST} -m post -T application/json \
     ${MOCK_BASE_URL}${MOCK_REPLY_PATH}
done
echo "Reply/mock - measure mock to get a baseline"
for i in `seq ${MEASUREMENT_ROUNDS}`; do
  ab -k -c ${PARALLEL_USER_COUNT} \
        -n ${NUMBER_OF_REQUEST_IN_TOTAL} \
        -u ${MOCK_REPLY_REQUEST} -m post -T application/json \
        -e reply/measurements/mock_${i}.csv \
        ${MOCK_BASE_URL}${MOCK_REPLY_PATH} > reply/measurements/mock_${i}
done

for i in `seq ${WARMUP_ROUNDS}`; do
  echo "Reply/Service - Warmup round #${i}"
  ab -k -c 10 \
     -n 1000 \
     -u ${SERVICE_REPLY_REQUEST} -T application/json \
     ${SERVICE_BASE_URL}${SERVICE_REPLY_PATH}
done
echo "Reply/service - measure"
for i in `seq ${MEASUREMENT_ROUNDS}`; do
  ab -k -c ${PARALLEL_USER_COUNT} \
        -n ${NUMBER_OF_REQUEST_IN_TOTAL} \
        -u ${SERVICE_REPLY_REQUEST} -T application/json \
        -e reply/measurements/service_${i}.csv \
        ${SERVICE_BASE_URL}${SERVICE_REPLY_PATH} > reply/measurements/service_${i}
done
