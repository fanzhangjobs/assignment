
# Create resource group
module "resource_group" {

  count =  var.env == "production"  ? 0 : 1

    source                              = "./modules/AzureResourceGroup"
    env                                 = var.env
    location                            = var.region
    resource_group_name                 = local.rg_name

}


# Create vNet
module "vm_vnet" {

  count = var.env == "production" ? 0 : 1

    source                              = "./modules/AzureVnet"
    resource_group_name                 = module.resource_group[0].resource_group_name
    env                                 = var.env
    location                            = var.region

    depends_on = [ module.resource_group ]
}


# Create Subnet for Azure Services
module "vm_subnet" {

  count = var.env == "production" ? 0 : 1

    source                              = "./modules/AzureSubnet"
    resource_group_name                 = module.resource_group[0].resource_group_name
    virtual_network_name                = module.vm_vnet[0].vnet_name
    env                                 = var.env
    location                            = var.region
    subnet_address_prefixes             = var.azvm_subnet_address_prefixes

    depends_on = [ module.resource_group,module.vm_vnet ]
}
