# Variables/EC2 -----------------------------------

variable "NFSServerSG" {}
variable "instance_type" {}
variable "subnet_idNFS" {}
variable "volume_size" {}
variable "instance_type_server_Client_Server" {}
variable "Client_ServerSG" {}
variable "subnet_id_Client_Server" {}
variable "volume_size_Client_Server" {}
#variable "iam_instance_profile_arn" {} #Ctrl+K Ctrl+C, Ctrl+K Ctrl+U