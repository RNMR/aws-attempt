variable "name" {
  type    = string
  default = "def"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "environment" {
  type = map(string)
}