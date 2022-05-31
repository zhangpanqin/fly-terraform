#!/bin/bash
set -eo pipefail

echo create test
echo create-$(date) >a.txt

# echo "{\"name\": \"4\"}"
#business logic
# /bin/cat <<END >ex.json
#   {"commit_id": "b8f2b8b", "environment": "$yolo", "tags_at_commit": "sometags", "project": "someproject", "current_date": "09/10/2014", "version": "someversion"}
# END
# cat ex.json
