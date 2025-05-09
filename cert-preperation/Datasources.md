Data sources are used to fetch data that is either managed by terraform other projects/modules  or manually or some other scripts 

when we want to incorporate such data into terraform we use data block


output "os-version" {
  value = data.local_file.os.content
}
data "local_file" "os" {
  filename = "/etc/os-release"
}

the file  "/etc/os-release" is not managed by terraform 
here filename "/etc/os-release" should be already present an that value is used in output 