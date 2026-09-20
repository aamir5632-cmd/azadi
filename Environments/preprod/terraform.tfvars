rgs = {
  rg1 = {
    name     = "Azadi-preprod"
    location = "Central India"
  }
  rg2 = {
    name     = "apreprod"
    location = "Central India"
  }
}

storage_accounts = {
  sa1 = {

    name                     = "saapreprod"
    resource_group_name      = "Azadi-preprod"
    location                 = "Central India"
    account_tier             = "Standard"
    account_replication_type = "LRS"

  }
}
