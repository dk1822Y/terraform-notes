# GCP DataFlow Flex-Template

## Summary

Dataflow Flex Templates allow you to use Docker images in Dataflow jobs. To create and upload JSON metadata, you'll need to use a `gcloud CLI` command. You can achieve the same behavior with Terraform code, which gives you a fully declarative IaC solution.

## gcloud CLI

First we'll need to build a dataflow flex-template using `gcloud dataflow flex-template build`

```hcl
{
    "name": "My Apache Beam pipeline",
    "parameters": [
        {
            "name": "output_table",
            "label": "BigQuery output table name.",
            "helpText": "Name of the BigQuery output table name.",
            "regexes": ["([^:]+:)?[^.]+[.].+"]
        }
    ]
}
```

## terraform

Using terraform we can generate a metadata JSON file. We'll be using prebuilt container image. Use the `gcloud dataflow flex-template` build command to create a Flex Template in your Cloud Storage bucket and the `google_dataflow_flex_template_job` resource to launch the Flex Template job, specifying the `container_spec_gcs_path`` and any necessary parameters.

```hcl
resource "google_storage_bucket_object" "flex_template_metadata" {
    bucket       = "my-unique-bucket"
    name         = "dataflow-templates/example/metadata.json"
    content_type = "application/json"

    content = jsonencode({
        image = "docker.pkg.dev/my-gcp-project-id/dataflow-templates/example:latest"
        sdkInfo = {
            language = "PYTHON"
        }
        metadata = {
            name = "My Apache Beam pipeline"
            parameters = [
                {
                    name = "output_table"
                    label = "BigQuery output table name."
                    helpText = "Name of the BigQuery output table name.",
                    regexes = ["([^:]+:)?[^.]+[.].+"]
                }
            ]
        }
    })
}

resource "google_dataflow_flex_template_job" "flex_template_job" {
    provider = google-beta

    name                    = "example_pipeline"
    region                  = "us-central1"
    container_spec_gcs_path = "gs://${google_storage_bucket_object.flex_template_metadata.bucket}/${google_storage_bucket_object.flex_template_metadata.name}"

    parameters = {
        output_table = "my-gcp-project-id/example_dataset/example_table"
    }
}
```
