resource "genesyscloud_processautomation_trigger" "trigger" {
  name       = "Sentiment Trigger on Wrap-up"
  topic_name = "v2.detail.events.conversation.{id}.acw"
  enabled    = true
  target {
    id   = var.workflow_id
    type = "Workflow"
    workflow_target_settings {
      data_format = "TopLevelPrimitives"
    }
  }
  match_criteria = jsonencode([
    {
      "jsonPath" : "mediaType",
      "operator" : "Equal",
      "value" : "VOICE"
    },
    {
      "jsonPath" : "wrapupCode",
      "operator" : "Equal",
      "value" : "${var.wrapupcode}"
    }
  ])
  event_ttl_seconds = 60
}