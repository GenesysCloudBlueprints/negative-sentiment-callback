
variable "data_action_category" {
  type        = string
  description = "The Data Action that is to be used in the Inbound Call Flow."
}

variable "create_scheduled_callback_name" {
  type        = string
  description = "The Data Action name that is to be used in the Inbound Call Flow."
}

variable "get_sentiment_name" {
  type        = string
  description = "The Data Action name that is to be used in the Inbound Call Flow."
}

variable "send_agentless_sms_name" {
  type        = string
  description = "The Data Action name that is to be used in the Inbound Call Flow."
}

variable "send_chat_group_notif_name" {
  type        = string
  description = "The Data Action name that is to be used in the Inbound Call Flow."
}

variable "update_external_tag_name" {
  type        = string
  description = "The Data Action name that is to be used in the Inbound Call Flow."
}

variable "sms_number" {
  type        = string
  description = "Purchased SMS number with the format `+11234567890`"
}

variable "callback_queue" {
  type        = string
  description = "The name of your configured queue for handling callbacks."
}