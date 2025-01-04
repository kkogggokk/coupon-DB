#!/bin/sh
ALERT_MSG="DELETE without WHERE clause detected!"
curl -X POST -H 'Content-type: application/json' \
    --data '{"text":"'"$ALERT_MSG"'"}' \
    https://hooks.slack.com/services/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