variable "oauthClientId" {
    description = "Client ID for the Genesys Cloud CX Org"
}
variable "oauthClientSecret" {
    description = "Client secret for the Genesys Cloud CS user"
}
variable "oauthAWSRegion" {
    description = "Region of the Genesys Cloud CX Org"
}
# New variables added for Email project
variable "division" {
    description = "Division to use in GCX"
}
variable "emailDomain" {
    description = "Email domain already configured on GCX UI"
}
variable "emailAddress" {
    description = "Email address to use for the domain"
}
variable "emailFromName" {
  description = "Friendly lable for email From property"
}
variable "emailAgent" {
    description = "Agent to add to routing queue"
}
variable "emailQueue" {
  description = "Routing queue to use in email flow"
}
variable "flowFilePath" {
  description = "Path to the Architect YAML"
  type = string
}