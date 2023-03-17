variable "public_subnet" {
  type = list
  default = ["subnet-06756f294abe01deb", "subnet-0b1b9747f50367fe1", "subnet-076ad0dd74aafdd80"]
}
variable "vpc_id" {
   type = string
}
variable "instance_id"{
   type = string
}
