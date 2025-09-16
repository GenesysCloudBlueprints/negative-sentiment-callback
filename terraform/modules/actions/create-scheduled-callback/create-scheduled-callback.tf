/*
  Creates the action
*/
resource "genesyscloud_integration_action" "create_scheduled_callback" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  contract_input = jsonencode({
    "type" = "object",
    "properties" = {
      "scriptId" = {
        "type" = "string"
      },
      "queueId" = {
        "type" = "string"
      },
      "phone" = {
        "type" = "string"
      },
      "dateTime" = {
        "description": "The scheduled date-time for the callback as an ISO-8601 string. For example: yyyy-MM-ddTHH:mm:ss.SSSZ.",
        "type" = "string"
      }
    }
  })
  contract_output = jsonencode({
    "type" = "object",
    "properties" = {}
  })
  config_request {
    # Use '$${' to indicate a literal '${' in template strings. Otherwise Terraform will attempt to interpolate the string
    # See https://www.terraform.io/docs/language/expressions/strings.html#escape-sequences
    request_url_template = "/api/v2/conversations/callbacks"
    request_type         = "POST"
    request_template     = "{\n\"scriptId\": \"$!{input.scriptId}\",\n\"callbackNumbers\": [ \"$${input.phone}\" ],\n\"queueId\": \"$${input.queueId}\",\n\"callbackScheduledTime\": \"$${input.dateTime}\"\n}"
    headers = {}
  }
  config_response {
    translation_map = {}
    translation_map_defaults = {}
    success_template = "$${rawResult}"
  }
}
