# this shell script calls the Databricks Repos API
# you can call this from your yaml file
DATABRICKS_URL=$1 # e.g. "https://southcentralus.azuredatabricks.net"
DB_REPO_ID=$2 # get this from Databricks, can store as a variable in Git CI/CD
DB_API=$3 # your Databricks API key (store this somewhere secure, like a vault)
BRANCH=$4 # branch you want refreshed
API_LINK="$DATABRICKS_URL/api/2.0/repos/$DB_REPO_ID"
AUTH="Authorization: Bearer $DB_API"
DATA_PAYLOAD="{\"branch\":\"$BRANCH\"}"
# Don't mess with the quotes in the statement below, bash does silly things around spaces
RESULT=$(curl -n -X PATCH "$API_LINK" -H "$AUTH" -d "$DATA_PAYLOAD")
echo $RESULT
# If our output does not have the ID field, this will have returned an error
echo $RESULT | jq -re .id
