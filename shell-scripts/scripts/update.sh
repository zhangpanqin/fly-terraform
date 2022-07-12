#!/bin/bash
set -eo pipefail
echo "update test 11"
echo update-$(date) >a.txt

echo "{\"name\": \"5\"}"
#business logic
# /bin/cat <<END >ex.json
#   {"commit_id": "b8f2b8b", "environment": "$yolo", "tags_at_commit": "sometags", "project": "someproject", "current_date": "09/10/2014", "version": "someversion"}
# END
