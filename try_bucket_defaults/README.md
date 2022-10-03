# `try_bucket_defaults`

```bash
https://cloud.google.com/storage/docs/gsutil/addlhelp/GlobalCommandLineOptions
gcloud -
```

```bash
unset CLOUDSDK_CORE_ACCOUNT CLOUDSDK_CORE_PROJECT
: ${CLOUDSDK_CORE_ACCOUNT:=aucampia@gmail.com}
: ${CLOUDSDK_CORE_PROJECT:=try-buckdef-660n}
export CLOUDSDK_CORE_ACCOUNT CLOUDSDK_CORE_PROJECT
declare -p CLOUDSDK_CORE_ACCOUNT CLOUDSDK_CORE_PROJECT

gcloud projects get-iam-policy ${CLOUDSDK_CORE_PROJECT}
gsutil iam get gs://${CLOUDSDK_CORE_PROJECT}-bucket/ | yq -P

{
RCLONE_GCS_TOKEN='{"access_token": "'"$(gcloud --account=${CLOUDSDK_CORE_ACCOUNT} auth print-access-token --impersonate-service-account=defaulted@${CLOUDSDK_CORE_PROJECT}.iam.gserviceaccount.com)"'"}' \
docker run --rm -i -e RCLONE_GCS_TOKEN docker.io/rclone/rclone cat :gcs:${CLOUDSDK_CORE_PROJECT}-bucket/object

RCLONE_GCS_TOKEN='{"access_token": "'"$(gcloud --account=${CLOUDSDK_CORE_ACCOUNT} auth print-access-token --impersonate-service-account=viewer@${CLOUDSDK_CORE_PROJECT}.iam.gserviceaccount.com)"'"}' \
docker run --rm -i -e RCLONE_GCS_TOKEN docker.io/rclone/rclone cat :gcs:${CLOUDSDK_CORE_PROJECT}-bucket/object
}

gcloud asset search-all-resources --scope=projects/${CLOUDSDK_CORE_PROJECT} | tee /var/tmp/gcloud-output.yaml | view -

gcloud asset analyze-iam-policy --project=${CLOUDSDK_CORE_PROJECT} --identity=serviceAccount:viewer@${CLOUDSDK_CORE_PROJECT}.iam.gserviceaccount.com --full-resource-name=//storage.googleapis.com/${CLOUDSDK_CORE_PROJECT}-bucket

gcloud asset analyze-iam-policy --project=${CLOUDSDK_CORE_PROJECT} --full-resource-name=//storage.googleapis.com/${CLOUDSDK_CORE_PROJECT}-bucket --permissions=storage.objects.get
gcloud policy-troubleshoot iam //storage.googleapis.com/projects/_/buckets/${CLOUDSDK_CORE_PROJECT}-bucket --permission=storage.objects.get --principal-email=viewer@${CLOUDSDK_CORE_PROJECT}.iam.gserviceaccount.com

gcloud asset analyze-iam-policy --project=${CLOUDSDK_CORE_PROJECT} --full-resource-name=//storage.googleapis.com/${CLOUDSDK_CORE_PROJECT}-bucket --permissions=storage.buckets.get
gcloud policy-troubleshoot iam //storage.googleapis.com/projects/_/buckets/${CLOUDSDK_CORE_PROJECT}-bucket --permission=storage.buckets.get --principal-email=viewer@${CLOUDSDK_CORE_PROJECT}.iam.gserviceaccount.com
```

## ...

```bash
gcloud --account=iwan.aucamp@coop.no auth print-access-token --impersonate-service-account=defaulted@sandbox-iwan-aucamp-e332.iam.gserviceaccount.com
```
