
provider "aws" {
  profile = "default"
  shared_credentials_file = "~/.aws/credentials"
  region = "us-east-1"
}

provider "aws" {
  alias = "oregon"
  profile = "default"
  shared_credentials_file = "~/.aws/credentials"
  region = "us-west-2"
}

provider "aws" {
  alias = "ohio"
  profile = "default"
  shared_credentials_file = "i~/.aws/credentials"
  region = "us-east-2"
}


