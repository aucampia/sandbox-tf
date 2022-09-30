```bash
https://cloud.google.com/storage/docs/gsutil/addlhelp/GlobalCommandLineOptions
gcloud -
```

```bash
: ${CLOUDSDK_CORE_ACCOUNT:=aucampia@gmail.com}
: ${CLOUDSDK_CORE_PROJECT:=try-buckdef-660n}
export CLOUDSDK_CORE_ACCOUNT CLOUDSDK_CORE_PROJECT

gsutil iam get gs://${CLOUDSDK_CORE_PROJECT}-bucket/ | yq -P
gcloud projects get-iam-policy ${CLOUDSDK_CORE_PROJECT}

RCLONE_GCS_TOKEN='{"access_token": "'"$(gcloud --account=aucampia@gmail.com auth print-access-token --impersonate-service-account=defaulted@${CLOUDSDK_CORE_PROJECT}.iam.gserviceaccount.com)"'"}' \
docker run --rm -it -e RCLONE_GCS_TOKEN docker.io/rclone/rclone cat :gcs:${CLOUDSDK_CORE_PROJECT}-bucket/object

RCLONE_GCS_TOKEN='{"access_token": "'"$(gcloud --account=aucampia@gmail.com auth print-access-token --impersonate-service-account=viewer@${CLOUDSDK_CORE_PROJECT}.iam.gserviceaccount.com)"'"}' \
docker run --rm -it -e RCLONE_GCS_TOKEN docker.io/rclone/rclone cat :gcs:${CLOUDSDK_CORE_PROJECT}-bucket/object


```

## ...

```bash
gcloud --account=iwan.aucamp@coop.no auth print-access-token --impersonate-service-account=defaulted@sandbox-iwan-aucamp-e332.iam.gserviceaccount.com
```
