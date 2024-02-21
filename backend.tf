terraform {
  cloud {
    organization = "Jester_Cloud"

    workspaces {
      name = "DataSync"
    }
  }
}