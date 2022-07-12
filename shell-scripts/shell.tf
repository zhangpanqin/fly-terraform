provider "shell" {
}

resource "shell_script" "github_repository" {
  lifecycle_commands {
    //I suggest having these command be as separate files if they are non-trivial
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    update = file("${path.module}/scripts/update.sh")
    read   = file("${path.module}/scripts/read.sh")
  }


  interpreter = ["/bin/bash", "-c"]

  //sets current working directory
  working_directory = path.module
  environment       = {
    yolo = "yolox"
  }
  triggers = {
    when_value_changed = 1
  }
}
