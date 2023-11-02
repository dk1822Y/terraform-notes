variable "notification_channels" {
  type = map(object({
    display_name = string
    type         = string
    labels       = map(string)
  }))
}

resource "google_monitoring_notification_channel" "alert_notification" {
  for_each = var.notification_channels

  display_name = each.value.display_name
  type         = each.value.type
  labels       = each.value.labels
}

resource "google_monitoring_alert_policy" "business_metric_alert_policy" {
  for_each = var.business_metric_alert_policies

  display_name = each.value.display_name
  combiner     = "OR"

  conditions {
    display_name = "Business Metric Condition"
    condition_threshold {
      filter      = each.value.filter
      duration    = each.value.duration
      comparison  = each.value.comparison
      threshold_value = each.value.threshold_value
      trigger {
        count = 1
      }
    }
  }

  notification_channels = [for nc in google_monitoring_notification_channel.alert_notification : nc.value.id]
}