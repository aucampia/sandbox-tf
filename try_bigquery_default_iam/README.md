# `try_bigquery_default_iam`

```bash
https://cloud.google.com/storage/docs/gsutil/addlhelp/GlobalCommandLineOptions
gcloud -
```

```bash
unset CLOUDSDK_CORE_ACCOUNT CLOUDSDK_CORE_PROJECT
: ${CLOUDSDK_CORE_ACCOUNT:=aucampia@gmail.com}
: ${CLOUDSDK_CORE_PROJECT:=try-bqdefiam-b4is}
export CLOUDSDK_CORE_ACCOUNT CLOUDSDK_CORE_PROJECT
declare -p CLOUDSDK_CORE_ACCOUNT CLOUDSDK_CORE_PROJECT

gcloud projects get-iam-policy ${CLOUDSDK_CORE_PROJECT}
bq show --project_id "${CLOUDSDK_CORE_PROJECT}" --format=prettyjson dataset_aaa

bq load --project_id "${CLOUDSDK_CORE_PROJECT}" --source_format NEWLINE_DELIMITED_JSON --replace "dataset_aaa.table_aaa" gs://try-bqdefiam-b4is-bucket/data.ndjson

bq query  --project_id "${CLOUDSDK_CORE_PROJECT}" --nouse_legacy_sql --format json 'SELECT * FROM dataset_aaa.table_aaa ORDER BY publish_time;' | jq -c '.[]'

# Query as defaulted service account
curl --request POST \
"https://bigquery.googleapis.com/bigquery/v2/projects/${CLOUDSDK_CORE_PROJECT}/queries" \
  -H "Authorization: Bearer $(gcloud --account=${CLOUDSDK_CORE_ACCOUNT} auth print-access-token --impersonate-service-account=defaulted@${CLOUDSDK_CORE_PROJECT}.iam.gserviceaccount.com)" \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{"query":"SELECT * FROM dataset_aaa.table_aaa ORDER BY publish_time;", "useLegacySql": false}' \
  --compressed

# Query as viewer service account
curl --request POST \
"https://bigquery.googleapis.com/bigquery/v2/projects/${CLOUDSDK_CORE_PROJECT}/queries" \
  -H "Authorization: Bearer $(gcloud --account=${CLOUDSDK_CORE_ACCOUNT} auth print-access-token --impersonate-service-account=viewer@${CLOUDSDK_CORE_PROJECT}.iam.gserviceaccount.com)" \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{"query":"SELECT * FROM dataset_aaa.table_aaa ORDER BY publish_time;", "useLegacySql": false}' \
  --compressed

```

## ...

```bash
gcloud --account=iwan.aucamp@coop.no auth print-access-token --impersonate-service-account=defaulted@sandbox-iwan-aucamp-e332.iam.gserviceaccount.com
```
