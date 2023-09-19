# Due to limited number of email domains available, 
# the email domain was created manually
# Using a data source to reference the existing resource
data "genesyscloud_routing_email_domain" "email_domain" {
  name = var.emailDomain
}

# Reference a user to make member of ACD queue
data "genesyscloud_user" "cloud_user" {
  email = var.emailAgent
}

# Create the division used for this demo
resource "genesyscloud_auth_division" "cxac_division" {
  name = var.division
  description = "Division for CX as Code Demo"
}

#
# Create routing queue for email
# Minimum configuration for this demonstration to work
resource "genesyscloud_routing_queue" "cxac_routing_queue" {
  name = var.emailQueue
  description = "Queue for CXaC routing email"
  division_id = genesyscloud_auth_division.cxac_division.id

  acw_wrapup_prompt = "MANDATORY_TIMEOUT"
  acw_timeout_ms = 300000
  skill_evaluation_method = "BEST"
  members {
    user_id = "${data.genesyscloud_user.cloud_user.id}"
  }
}

# Create email address using existing domain
resource "genesyscloud_routing_email_route" "cxac_email_address" {
  depends_on = [ genesyscloud_flow.simple_email_flow ]
  domain_id = "${data.genesyscloud_routing_email_domain.email_domain.id}"
  pattern = var.emailAddress
  from_name = var.emailFromName
  from_email = "${var.emailAddress}@${var.emailDomain}" 
  flow_id = genesyscloud_flow.simple_email_flow.id
  # if you configure both queue_id and flow_id the flow will not get used...
  #queue_id = genesyscloud_routing_queue.cxac_routing_queue.id
}

# Deploy Architect Flow
resource "genesyscloud_flow" "simple_email_flow" {
  depends_on = [  
    genesyscloud_routing_queue.cxac_routing_queue,
    genesyscloud_auth_division.cxac_division
  ]
  filepath = var.flowFilePath
  file_content_hash = filesha256(var.flowFilePath)
}
