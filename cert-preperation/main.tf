resource "local_file" "hello" {
  content = "Hello"
  filename = "./hello.txt"
}