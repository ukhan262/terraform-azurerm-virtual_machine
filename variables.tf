variable "vm_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "vm_size" {}
variable "publisher" {}
variable "offer_product" {}
variable "sku_plan" {}
variable "image_version" {
    default = null
}
variable "admin_username" {
    default = null
}
variable "admin_password" {}
variable "tags" {}