# Terraform module to create a Pub/Sub topic with subscriptions
#
# This module creates a Pub/Sub topic with subscriptions of the following types:
# - push (https://cloud.google.com/pubsub/docs/push)
# - pull (https://cloud.google.com/pubsub/docs/pull)
# - bigquery (https://cloud.google.com/pubsub/docs/subscriber#create-subscription-bigquery-target)
# - cloud storage (https://cloud.google.com/pubsub/docs/subscriber#create-subscription-storage-target)
#
# The module takes a list of subscriptions of each type as input.
# It creates the topic and subscriptions in the given project.

module "pubsub" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 6.0"

  # The topic name
  topic      = "tf-topic"

  # The project ID where the topic and subscriptions will be created
  project_id = var.project_id

  # List of Pub/Sub push subscriptions
  # See https://cloud.google.com/pubsub/docs/reference/rest/v1/projects.subscriptions#Subscription for more details
  push_subscriptions = [
    {
      name                       = "push"                                               # required
      ack_deadline_seconds       = 20                                                   # optional
      push_endpoint              = "https://example.com"                                # required
      oidc_token                 = {}                                                   # optional
      expiration_policy          = {}                                                   # optional
      dead_letter_policy         = {}                                                   # optional
      retry_policy               = {}                                                   # optional
      filter                     = "attributes.domain = \"com\""                        # optional
      enable_message_ordering    = false                                                # optional
      topic_message_retention_duration = ""                                            # optional
    }
  ]

  # List of Pub/Sub pull subscriptions
  # See https://cloud.google.com/pubsub/docs/reference/rest/v1/projects.subscriptions#Subscription for more details
  pull_subscriptions = [
    {
      name                         = "pull"                                               # required
      ack_deadline_seconds         = 20                                                   # optional
      expiration_policy            = {}                                                     # optional
      dead_letter_policy           = {}                                                    # optional
      retry_policy                 = {}                                                     # optional
      filter                       = "attributes.domain = \"com\""                        # optional
      enable_message_ordering      = false                                                # optional
      topic_message_retention_duration = ""                                              # optional
      oidc_token                   = {}                                                   # optional
    }
  ]

  # List of Pub/Sub subscriptions to BigQuery
  # See https://cloud.google.com/pubsub/docs/reference/rest/v1/projects.subscriptions#Subscription for more details
  bigquery_subscriptions = [
    {
      name                = "bigquery"              # required
      topic_name          = "projects/my-pubsub-project/topics/example-topic" # required
      dataset             = "example-dataset"     # optional
      table               = "example-table"       # optional
      use_topic_schema    = true                  # optional
      write_metadata      = false                 # optional
      drop_unknown_fields = false                 # optional
      max_delivery_attempts = 0                   # optional
      expiration_policy = {}                       # optional
      dead_letter_policy = {}                      # optional
      retry_policy       = {}                      # optional
      filter             = ""                      # optional
    }
  ]

  # List of Pub/Sub subscriptions to Cloud Storage
  # See https://cloud.google.com/pubsub/docs/reference/rest/v1/projects.subscriptions#Subscription for more details
  cloud_storage_subscriptions = [
    {
      name            = "cloud-storage"  # required
      topic_name      = "projects/my-pubsub-project/topics/example-topic" # required
      bucket          = "example-bucket" # required
      filename_prefix = "log_events_"    # optional
      filename_suffix = ".avro"          # optional
      max_delivery_attempts = 0           # optional
      expiration_policy = {}               # optional
      dead_letter_policy = {}              # optional
      retry_policy       = {}              # optional
      filter             = ""              # optional
      output_format      = "json"          # optional
      write_metadata      = false         # optional
    }
  ]
}

