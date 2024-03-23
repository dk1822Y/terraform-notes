# Creating Project and BigQuery Dataset

This Terraform module provisions a BigQuery dataset and provisions a Google Cloud Platform project with specified configurations.

## Inputs

- `project_id` (string): The ID of the Google Cloud project.
- `project_name` (string): The name of the Google Cloud project.
- `org_id` (string): The ID of the organization where the project belongs.
- `usage_bucket` (string): The name of the bucket used for resource usage data.
- `env` (string): The environment for the project (e.g., `dev`, `prod`).
- `activate_apis` (list of strings): List of Google Cloud APIs to activate for the project.
- `labels` (map of string): A map of labels to apply to the project.

- `project_id` (string): The ID of the Google Cloud project.
- `project_name` (string): The name of the Google Cloud project.
- `org_id` (string): The ID of the organization where the project belongs.
- `usage_bucket` (string): The name of the bucket used for resource usage data.
- `env` (string): The environment for the project (e.g., `dev`, `prod`).
- `activate_apis` (list of strings): List of Google Cloud APIs to activate for the project.
- `labels` (map of string): A map of labels to apply to the project.
