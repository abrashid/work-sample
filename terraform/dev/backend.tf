terraform {
  backend "s3" {
    profile = "my_profile" # Use credentials in `~/.aws/credentials`
    bucket  = "my_app_dev"
    key     = "dev"
    region  = "eu-west-1"
  }
}
