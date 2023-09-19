# Genesys Cloud - CX as Code TOI
## Examples and Presentation Materials for CX as Code TOI
## Training Event Berlin, September, 2023
### Presented by Andrew APPLETON (andrew.appleton@genesys.com)
### Version 2.0
---

# Agenda
## Trainer: Andrew Appleton
---
## Schedule
## 2023.09.19

---
## Rename any terraform.tfvars.txt file to terraform.tfvars

* ## Session #1: CX as Code ##
    * What is CX as Code?
        * Developer Tools
        * Position in Developer Tools ecosystem
    * What is Terraform?
        * What are the goals of Terraform?
        * How does Terraform work
        * Terraform vs competitors
        * Terraform Cloud
    * Genesys CX as Code Provider
        * Open Source
        * Limitations
        * Versioning
        * Documentation
    * Setting up your environment
        * Are you a Mac or a PC?
        * Installing Terraform
        * VS Code (optional)
    * CX as Code Examples:
        * The structure of the Terraform scripts
            * How to reference the Genesys CX as Code Provider
            * Debugging
            * Secrets and Credentials
        * Example #1: Create Skills
            * Reviewing the script
            * Basic steps...
                * Init
                * Plan
                * Apply
            * Reviewing the created resources
            * Reviewing the debug log
        * Example #2: Data Sources and Dependencies
            * Referencing existing objects through Data Sources
        * Example #3: Exporting Data
        * External Dependencies
            * Loading data from CSV file
        * Example #5: Email Project
            * Email workflow format
            * Use of variables in Terraform script
            * Validating
        
* ## Session #2: Archy and Platform API CLI ##

* ## What Next? ##
* Pipelining
    * Terraform Cloud
    * Github Actions

