```bash
https://cloud.google.com/storage/docs/gsutil/addlhelp/GlobalCommandLineOptions
gcloud -
```

```bash
RCLONE_GCS_TOKEN='{"access_token": "'"$(gcloud --account=aucampia@gmail.com auth print-access-token --impersonate-service-account=defaulted@try-buckdef-660n.iam.gserviceaccount.com)"'"}' \
docker run --rm -it -e RCLONE_GCS_TOKEN docker.io/rclone/rclone cat :gcs:try-buckdef-660n-bucket/object

RCLONE_GCS_TOKEN='{"access_token": "'"$(gcloud --account=aucampia@gmail.com auth print-access-token --impersonate-service-account=viewer@try-buckdef-660n.iam.gserviceaccount.com)"'"}' \
docker run --rm -it -e RCLONE_GCS_TOKEN docker.io/rclone/rclone cat :gcs:try-buckdef-660n-bucket/object
```

## ...

```bash
gcloud --account=iwan.aucamp@coop.no auth print-access-token --impersonate-service-account=defaulted@sandbox-iwan-aucamp-e332.iam.gserviceaccount.com
```
