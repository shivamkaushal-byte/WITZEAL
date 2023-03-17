variable "public_subnet" {
  type = list
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}
variable "vpc_id" {
   type = string
}
variable "instance_id"{
   type = string
}
