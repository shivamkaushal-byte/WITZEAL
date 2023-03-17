variable "public_subnet" {
  type = list
  default = ["subnet-06756f294abe01deb", "subnet-04580cce74aab69e7"]
}
variable "vpc_id" {
   type = string
}
variable "instance_id"{
   type = string
}
