// Create a Data Action integration
module "data_action" {
  source                          = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module?ref=main"
  integration_name                = "Send SMS and Create Supervisor Callback"
  integration_creds_client_id     = var.client_id
  integration_creds_client_secret = var.client_secret
}

// Create a Create Scheduled Callback Data Action
module "create_scheduled_callback_data_action" {
  source             = "./modules/actions/create-scheduled-callback"
  action_name        = "Create Scheduled Callback"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

// Create a Get Sentiment Data Action
module "get_sentiment_data_action" {
  source             = "./modules/actions/get-sentiment"
  action_name        = "Get Sentiment"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

// Create a Send Agentless SMS Data Action
module "send_agentless_sms_data_action" {
  source             = "./modules/actions/send-agentless-sms"
  action_name        = "Send Agentless SMS"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

// Create a Send Chat Group Notification Data Action
module "send_chat_group_notif_data_action" {
  source             = "./modules/actions/send-chat-group-notif"
  action_name        = "Send Chat Group Notification"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

// Create a Update External Tag Data Action
module "update_external_tag_data_action" {
  source             = "./modules/actions/update-external-tag"
  action_name        = "Update External Tag"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

// Get Queue ID of callback queue
data "genesyscloud_routing_queue" "callback_queue" {
  name = var.callback_queue
}

// Configures the architect workflow and inbound call flow
module "archy_flow" {
  source                           = "./modules/flow"
  data_action_category             = module.data_action.integration_name
  create_scheduled_callback_name   = module.create_scheduled_callback_data_action.action_name
  get_sentiment_name               = module.get_sentiment_data_action.action_name
  send_agentless_sms_name          = module.send_agentless_sms_data_action.action_name
  send_chat_group_notif_name       = module.send_chat_group_notif_data_action.action_name
  update_external_tag_name         = module.update_external_tag_data_action.action_name
  sms_number                       = var.sms_number
  callback_queue                   = data.genesyscloud_routing_queue.callback_queue.id

  depends_on = [ module.data_action, 
                  module.create_scheduled_callback_data_action, 
                  module.get_sentiment_data_action, 
                  module.send_agentless_sms_data_action,
                  module.send_chat_group_notif_data_action,
                  module.update_external_tag_data_action
                ]
}

// Get ID of Wrap-up Code
data "genesyscloud_routing_wrapupcode" "wrapupcode" {
  name = var.wrapup_code
}

// Create a Trigger
module "trigger" {
  source       = "./modules/trigger"
  workflow_id  = module.archy_flow.flow_id
  wrapupcode   = data.genesyscloud_routing_wrapupcode.wrapupcode.id
  depends_on   = [ module.archy_flow ]
}
