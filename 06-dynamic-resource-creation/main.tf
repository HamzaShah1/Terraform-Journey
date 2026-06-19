resource "null_resource" "server" {
    count = 3

    triggers = {
        name = ["web", "app", "monitoring"][count.index]
    }
}