module "bigquery_dataset" {
    source  = "terraform-google-modules/bigquery/google"
    version = "~> 2.0"

    project_id = "var.projectid"
    dataset_id = "var.datasetid"
    location   = "var.location"

    labels = {
    "billable"       = "true"
    "data_owner"     = "var.data_owner"
    "classification" = "confidential"
  }
  access = [
    {
      role          = "roles/bigquery.dataViewer"
      service_account_email = "service_account@project.iam.gserviceaccount.com"
    },
  ]
}
