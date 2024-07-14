#Installing the Application
resource "null_resource" "app" {

  triggers = {
    always_run = "${timestamp()}"
  }

  count = local.INSTANCE_COUNT

  provisioner "remote-exec" {
      connection {
      type     = "ssh"
      user     = local.SSH_USERNAME
      password = local.SSH_PASSWORD
      host     = element(local.INSTANCE_PRIVATE_IPS, count.index)
    }
    inline = [
        "sleep 30" ,
        "ansible-pull -U https://github.com/Adarsh-Pixel/ansible.git -e MONGODB_ENDPOINT=${data.terraform_remote_state.db.outputs.MONGODB_ENDPOINT}-e ENV=dev -e APP_VERSION=${var.APP_VERSION} -e COMPONENT=${var.COMPONENT} roboshop-pull.yml"
    ]
  }
}