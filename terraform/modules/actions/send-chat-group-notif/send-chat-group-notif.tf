/*
  Creates the action
*/
resource "genesyscloud_integration_action" "send_chat_group_notif" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  contract_input = jsonencode({
    "type" = "object",
    "properties" = {
      "message" = {
        "type" = "string"
      },
      "metadata": {
        "type": "string"
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
    request_url_template = "https://apps.mypurecloud.com:443/webhooks/api/v1/webhook/d7a2ea24-d582-4513-b8da-a0b22bf2204a"
    request_type         = "POST"
    request_template     = "{\"message\": \"$${input.message}\",\"metadata\": \"$${input.metadata}\"}"
    headers = {}
  }
  config_response {
    translation_map = {}
    translation_map_defaults = {}
    success_template = "$${rawResult}"
  }
}
