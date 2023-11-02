resource "google_monitoring_alert_policy" "cpu_alert" {
  display_name = "CPU Utilization Alert"
  combiner     = "OR"
  auto_close {
    duration = "3600s"
  }

  conditions {
    display_name = "CPU Utilization Condition"
    condition_threshold {
      filter      = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" resource.type=\"gce_instance\" resource.label.\"instance_id\"=\"${var.instance_id}\""
      duration    = "60s"
      comparison  = "COMPARISON_GT"
      threshold_value = 80
      trigger {
        count = 1
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email.name,
  ]
}

resource "google_monitoring_notification_channel" "email" {
  display_name = "Email Notification Channel"
  type         = "email"
  labels = {
    email_address = "example@example.com"
  }
}