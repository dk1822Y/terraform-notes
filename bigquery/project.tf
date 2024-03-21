module "project" {
    source  = "terraform-google-modules/project/google"
    version = "3.3.0"

    project_id              = "var.projectid"
    project_name            = "var.projectname"
    org_id                  = "var.org_id" 
    usage_bucket            = "var.bucketname" 

    env                     =  var.env

    activate_apis = [
    # Required
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    # Project specific
    "storage.googleapis.com",
    "bigquery.googleapis.com",
    "bigquerystorage.googleapis.com",
    "bigqueryconnection.googleapis.com",
    "pubsub.googleapis.com"
    ]
    labels = {
    "classification" = "confidential"
    "organization"   = "var.org_id"
    "billing"        = "var.billing"
    "data_owner"     = "var.data_owner"
  }
}