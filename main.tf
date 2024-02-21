# ROOT/Main ------------------------------------
module "IAM" {
  source = "./IAM"
}

module "networking" {
  source      = "./Network"
  vcp_cidr    = "10.10.0.0/16"
  public_cidr = "10.10.1.0/24"
  server_cidr = "10.10.2.0/24"
}

# Linux AWS Instance ----------------------------------------------
module "Compute" {
  source        = "./EC2"
  NFSServerSG   = module.networking.NFSSGServerSG_Output # Cuando se llama un ID se hace por outputs, aqui es module networking pq el archivo esta ahi
  instance_type = "t3.micro"
  subnet_idNFS  = module.networking.NFSSubnet_Output
  volume_size   = 10
  #iam_instance_profile_arn = module.IAM.IAM_Output # 1- Creando la instancia invento la variable, 2- Creo la variable en variable.tf 3- Creo eloutput en IAM 4- Le doy valor en Main ROOT

# On-Prem Client Instance ----------------------------------------------
  instance_type_server_Client_Server = "t3.micro"
  Client_ServerSG                    = module.networking.Client_ServerSG_Output
  subnet_id_Client_Server            = module.networking.Client_ServerSubnet_Output
  volume_size_Client_Server          = 10


}
