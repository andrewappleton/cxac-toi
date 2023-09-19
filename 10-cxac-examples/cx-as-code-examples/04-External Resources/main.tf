locals {
    queues = csvdecode(file("${path.module}/queues.csv"))
}

resource "genesyscloud_routing_queue" "cxac_queues" {

    count = length(local.queues)

    name                = local.queues[count.index].name
    description         = local.queues[count.index].description
    acw_wrapup_prompt   = local.queues[count.index].acw_wrapup_prompt 
    acw_timeout_ms      = local.queues[count.index].acw_timeout_ms

} 















