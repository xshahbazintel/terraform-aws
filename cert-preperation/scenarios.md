i have applied some resources in aws using terrafor, someone else did changes to one resource manually in UI, how can i bring changes to my tfstate file 
This is called drift detection, if you just want to update statefile do 
terraform refresh
on which resource changes were applied, update the resource block with changes made in UI
now run terraform plan, this should show now changes to apply 

what does terraform plan do?

By default, Terraform performs the following operations when it creates a plan:

Reads the current state of any already-existing remote objects to make sure that the Terraform state is up-to-date.
Compares the current configuration to the prior state and noting any differences.
Proposes a set of change actions that should, if applied, make the remote objects match the configuration.