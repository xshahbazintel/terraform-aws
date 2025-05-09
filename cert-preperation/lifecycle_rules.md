when you apply changes to infra, some resources need to be deleted first and terraform creates a new resources after that, for example when you use local_file provider and make changes to file permissions this will lead to deletion of that file first and creates a newfile.
you can control this behaviour using lifecycle policies

resource "local_file" "whale" {
  filename = "/root/whale"
  content = "whale"
  
}

resource "local_file" "whale" {
  filename = "/root/whale"
  content = "whale"
  filepermissions = "0777"
  
}

this will delete file first and create a new one, you can change the behaviour using 
lifecycle {
    create_before_destroy = true
  }

this will create file first and delete old file later

resource "local_file" "whale" {
  filename = "/root/whale"
  content = "whale"
  lifecycle {
    create_before_destroy = true
  }
  
}

lifecycle {
    prevent_destroy = true
  }

this will prevent deletion and recreation of file, how ever terraform destroy cant stop deletion, but when you apply then this will affect

lifecycle {
     ignore_changes = [
      tags
    ]
  }

ignore_changes will be used when you want to ignore some changes made to infra outside terraform, suppose when someone made changes to tag to aws instance you dont want to update the instance onceagain, so using this block you can ignore changes
