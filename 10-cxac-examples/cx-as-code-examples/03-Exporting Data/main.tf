resource "genesyscloud_tf_export" "export" {
    directory       = "./export-data"
    include_state_file = false
    export_as_hcl = true
    log_permission_errors = true
    # Export everything... Can also omit completely as default is to export all...
    # include_filter_resources = []
    # Export only queues and skills
    include_filter_resources = [    
        "genesyscloud_routing_queue",
        "genesyscloud_routing_skill",
    ]
    # Export specific queues and skills
    # include_filter_resources = [               
    #     "genesyscloud_routing_queue::CXaC_Q_Default",
    #     "genesyscloud_routing_skill::CXaC_Example_Skill_ARA"
    # ]
    # exclude_attributes = [
    #     "genesyscloud_routing_queue.media_settings_call",
    #     "genesyscloud_routing_queue.media_settings_callback",
    #     "genesyscloud_routing_queue.media_settings_chat",
    #     "genesyscloud_routing_queue.media_settings_email",
    #     "genesyscloud_routing_queue.media_settings_message",
    #     "genesyscloud_routing_queue.description"
    # ]
    # exclude_filter_resources = [
    #     "genesyscloud_architect_user_prompt",
    #     "genesyscloud_script"
    # ]
}





