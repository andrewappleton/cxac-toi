# Notes on *Exporting Data* example
## Initialize Terraform Environment...
```
ara@anfield.local:03-Exporting Data [main *] $ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding mypurecloud/genesyscloud versions matching ">= 1.14.0"...
- Installing mypurecloud/genesyscloud v1.16.0...
- Installed mypurecloud/genesyscloud v1.16.0 (signed by a HashiCorp partner, key ID 14124804A3595BCF)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
ara@anfield.local:03-Exporting Data [main *] $ 
```

## Review Terraform Execution Plan...
```
ara@anfield.local:03-Exporting Data [main *] $ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # genesyscloud_tf_export.export will be created
  + resource "genesyscloud_tf_export" "export" {
      + directory             = "./export-data"
      + export_as_hcl         = false
      + id                    = (known after apply)
      + include_state_file    = false
      + log_permission_errors = true
    }

Plan: 1 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
ara@anfield.local:03-Exporting Data [main *] $ 
```
## Exercise #1 - Export ALL
Uncomment the ` resource_types = []` line
NOTE: This is not strictly necessary.  If no resource_type is specifed, then all resources will be exported.
![Exercise #1 - Export ALL](./images/00-Exercise-01.png)

## Execute Terraform Script...
```
ara@anfield.local:03-Exporting Data [main *] $ terraform apply --auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # genesyscloud_tf_export.export will be created
  + resource "genesyscloud_tf_export" "export" {
      + directory             = "./export-data"
      + export_as_hcl         = false
      + id                    = (known after apply)
      + include_state_file    = false
      + log_permission_errors = true
    }

Plan: 1 to add, 0 to change, 0 to destroy.
genesyscloud_tf_export.export: Creating...
genesyscloud_tf_export.export: Still creating... [10s elapsed]
genesyscloud_tf_export.export: Still creating... [20s elapsed]
genesyscloud_tf_export.export: Still creating... [30s elapsed]
genesyscloud_tf_export.export: Creation complete after 30s [id=export-data/genesyscloud.tf.json]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
ara@anfield.local:03-Exporting Data [main *] $ 
```
## Note the directory and set of files created (or overwritten if already exists)
![export-data directory created at root of Terraform directory...](./images/01-Export%20ALL.png)

Review the file created to learn the structure of the output file

## Exercise #2 - Export Queues and Skills
Comment out the  `resource_types = []` line and then uncomment the following lines:
```
resource_types = [    
    "genesyscloud_routing_queue",
    "genesyscloud_routing_skill",
]
```
![Setting up for exporting Queues and Skills](./images/02-Export%20Queues%20and%20Skills.png)
## Execute Terraform script...
```
ara@anfield.local:03-Exporting Data [main *] $ terraform apply --auto-approve
genesyscloud_tf_export.export: Refreshing state... [id=export-data/genesyscloud.tf.json]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # genesyscloud_tf_export.export must be replaced
-/+ resource "genesyscloud_tf_export" "export" {
      ~ id                    = "export-data/genesyscloud.tf.json" -> (known after apply)
      + resource_types        = [ # forces replacement
          + "genesyscloud_routing_queue",
          + "genesyscloud_routing_skill",
        ]
        # (4 unchanged attributes hidden)
    }

Plan: 1 to add, 0 to change, 1 to destroy.
genesyscloud_tf_export.export: Destroying... [id=export-data/genesyscloud.tf.json]
genesyscloud_tf_export.export: Destruction complete after 0s
genesyscloud_tf_export.export: Creating...
genesyscloud_tf_export.export: Creation complete after 7s [id=export-data/genesyscloud.tf.json]

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
ara@anfield.local:03-Exporting Data [main *] $ 
```
NOTE: In the plan output you will see that the previously created output/export file will be replaced:
![Plan to replace existing export file](./images/02.5-Replacing%20file%20resource.png)

Review the file created to learn the structure of the output file

## Exercise #3 - Export only specific named resources and types
Comment out the previous lines and uncomment the following lines:
```
resource_types = [               
    "genesyscloud_routing_queue::CXaC_Q_Default",
    "genesyscloud_routing_skill::CXaC_Example_Skill_ARA"
]
```
## Execute the Terraform script...
```
ara@anfield.local:03-Exporting Data [main *] $ terraform apply --auto-approve
genesyscloud_tf_export.export: Refreshing state... [id=export-data/genesyscloud.tf.json]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # genesyscloud_tf_export.export must be replaced
-/+ resource "genesyscloud_tf_export" "export" {
      ~ id                    = "export-data/genesyscloud.tf.json" -> (known after apply)
      ~ resource_types        = [ # forces replacement
          - "genesyscloud_routing_queue",
          - "genesyscloud_routing_skill",
          + "genesyscloud_routing_queue::CXaC_Q_Default",
          + "genesyscloud_routing_skill::CXaC_Example_Skill_ARA",
        ]
        # (4 unchanged attributes hidden)
    }

Plan: 1 to add, 0 to change, 1 to destroy.
genesyscloud_tf_export.export: Destroying... [id=export-data/genesyscloud.tf.json]
genesyscloud_tf_export.export: Destruction complete after 0s
genesyscloud_tf_export.export: Creating...
genesyscloud_tf_export.export: Creation complete after 6s [id=export-data/genesyscloud.tf.json]

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
ara@anfield.local:03-Exporting Data [main *] $ 
```
Note the plan to remove the export with all queues and skills to replace with specifically named queue and skill
![Named resources](./images/03-Exporting%20Named%20Resources.png)

## Exercise #4 - Exclude attributes from exported resources
Next, we will uncomment the `exclude_attributes` section from the main.tf file:
![Uncomment exclude_attributes section](./images/04-Exclude%20Attributes.png)

Note in the previous export that the attributes have been exported:
![Attributes to exclude](./images/04.1-Excluded%20Attributes.png)

## Execute the Terraform script...
```
ara@anfield.local:03-Exporting Data [main *] $ terraform apply --auto-approve
genesyscloud_tf_export.export: Refreshing state... [id=export-data/genesyscloud.tf.json]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # genesyscloud_tf_export.export must be replaced
-/+ resource "genesyscloud_tf_export" "export" {
      + exclude_attributes    = [ # forces replacement
          + "genesyscloud_routing_queue.media_settings_call",
          + "genesyscloud_routing_queue.media_settings_callback",
          + "genesyscloud_routing_queue.media_settings_chat",
          + "genesyscloud_routing_queue.media_settings_email",
          + "genesyscloud_routing_queue.media_settings_message",
          + "genesyscloud_routing_queue.description",
        ]
      ~ id                    = "export-data/genesyscloud.tf.json" -> (known after apply)
        # (5 unchanged attributes hidden)
    }

Plan: 1 to add, 0 to change, 1 to destroy.
genesyscloud_tf_export.export: Destroying... [id=export-data/genesyscloud.tf.json]
genesyscloud_tf_export.export: Destruction complete after 0s
genesyscloud_tf_export.export: Creating...
genesyscloud_tf_export.export: Creation complete after 7s [id=export-data/genesyscloud.tf.json]

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
ara@anfield.local:03-Exporting Data [main *] $ 
```
Note that attributes specified in the `exclude_attributes` section are no longer exported:
![Null values on exported resources](./images/04.2-Null%20exported%20resources.png)

There is no real need to run a `terraform destroy` on this project as only local resources are created, however for consistency we will run the destroy and note that although the folder is left in place, any files created within the folder are removed:
![Removed Files](./images/04.3-Removed%20Files.png)