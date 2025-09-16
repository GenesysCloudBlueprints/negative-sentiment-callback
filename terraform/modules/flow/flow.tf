resource "genesyscloud_flow" "workflow" {
  filepath = "${path.module}/Send_SMS_and_Create_Supervisor_Callback.yaml"
  substitutions = {
    flow_name                      = "Send SMS and Create Supervisor Callback"
    division                       = "Home"
    default_language               = "en-us"
    data_action_category           = var.data_action_category
    create_scheduled_callback_name = var.create_scheduled_callback_name
    get_sentiment_name             = var.get_sentiment_name
    send_agentless_sms_name        = var.send_agentless_sms_name
    send_chat_group_notif_name     = var.send_chat_group_notif_name
    update_external_tag_name       = var.update_external_tag_name
    sms_number                     = var.sms_number
    callback_queue                 = var.callback_queue
  }
}