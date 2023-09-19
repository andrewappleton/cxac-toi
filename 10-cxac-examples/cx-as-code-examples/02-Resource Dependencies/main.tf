resource "genesyscloud_auth_division" "cxac_division" {
  name = "CXaC_Division"
  description = "Division used for CX as Code TOI - Berlin 2023"
}

resource "genesyscloud_routing_queue" "cxac_routing_queue" {
  name = "CXaC_Q_Default"
  description = "Default queue"
  division_id = genesyscloud_auth_division.cxac_division.id
  members = [
    {user_id = genesyscloud_user.cxac_user_01.id, ring_num = 1},
    {user_id = genesyscloud_user.cxac_user_02.id, ring_num = 1}
  ]
  #Comment this line on first run to show error appearing in UI
  #acw_timeout_ms = 30000
}

resource "genesyscloud_user" "cxac_user_01" {
  name = "CXaC User-01"
  password = "Q1hhQyBVc2VyLTAxCg=="
  email = "cxac-user01@cxac.mypurecloud.de"
  division_id = genesyscloud_auth_division.cxac_division.id
  state = "active"
  
}

resource "genesyscloud_user" "cxac_user_02" {
  name = "CXaC User-02"
  password = "Q1hhQyBVc2VyLTAyCg=="
  email = "cxac-user02@cxac.mypurecloud.de"
  division_id = genesyscloud_auth_division.cxac_division.id
  state = "active"  
}
