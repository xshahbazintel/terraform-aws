By default, a resource block configures one real infrastructure object. (Similarly, a module block includes a child module's contents into the configuration one time.) However, sometimes you want to manage several similar objects (like a fixed pool of compute instances) without writing a separate block for each one. Terraform has two ways to do this: count and for_each.

Count:
count is used to create the number of resources mentioned in count variable 

1. resource "local_sensitive_file" "name" {
    filename = "/root/sample1.txt"
    content = "sample1"
    count = 3 

}

tries to create 3 resources but as file name and location is same, you can see only one 1 file, even if terraform creates 3 resources


2. here terraform takes length of list and tries to creates file name at index positions, however if you delete one element from list the index positions get rearranged and tries to create once again which is not desireable
resource "local_sensitive_file" "name" {
    filename = var.files_list[count.index]
    content = "sample1"
    count = len(var.files_list) 

}

variable "files_list" {
default = ["/root/sample1.txt", "/root/sample2.txt"]
}



for-each: 
this works only with maps or sets

for-each fixes problems with count, 

resource "local_sensitive_file" "name" {
    filename = each.value
    content = var.content
    for_each = toset(var.users)

}




