module "iam_iam-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.28.0"
  name = "max"
  create_iam_access_key = false
  create_iam_user_login_profile = false
  # insert the 1 required variable here
}


how to refer modules in main.tf


module "module_sampe" #this can be anything {

  source = ""  #nrequired field
  version = "" #not mandatory
}