#!/bin/bash

TO_NUMBER="$1"
SUBJECT="$2"
MESSAGE="$3"

. /usr/local/etc/smsc/smsc.conf

SMSC_URL=${SMSC_URL:-"https://smsc.ru/sys/send.php"}

TO_NUMBER=$(echo "${TO_NUMBER}" | sed 's/[^0123456789]//g')

NL='
'

RESULT=$(curl --get --silent --show-error \
    --data-urlencode "login=${USER_ID}" \
    --data-urlencode "psw=${PASSWORD}" \
    --data-urlencode "phones=${TO_NUMBER}" \
    --data-urlencode "mes=${SUBJECT}${NL}${MESSAGE}" \
    "${SMSC_URL}" 2>&1
)

STATUS=$?

echo ${RESULT}

exit ${STATUS}
