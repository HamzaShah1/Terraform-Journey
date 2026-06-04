the main terraform workflow is the following:

write a config -> terraform init -> terraform fmt -> terraform validate -> terraform plan -> terraform apply -> inspect resources - > terraform destroy

what does this mean?:
terraform init - initialises the project; it downloads the providews anfd creates .terraform/, it prepares the backend, prepares the modules. basically prtepares the folwder it is in to run terraform. when i did terraform init; it created the .terraform/ folder; which contains downloaded providers, module cache, and terraform internal data. it also made .terraform.lock/hcl - this locks the provider versions; which is important for developers as without lock files, one engineer might use provider 5.0 and another might use another version (eg. 5.4).

terraform fmt - formats the terraform code consistently: this matters for readability, consistency, CI enforcement. real teams often fail CI if the formatting is wrong.

terraform validate - checks the syntax and internal copnsistency; it DOES NOT: deploy anything, use AWS heavily, and create resources. it only checks syntax, references, and argument validity.

terraform plan - this is the most important safety command; terraform compares the .tf files, the terraform state, real infrastructure; and then it shows what will be created, changed, and destroyed. this is an ijmportant safety review step: when you do terraform plan it lists out the planned chnages for you to review before executing; this is one reason companies trust it.

terraform apply - actaully performs the changes; its a good habit to do terraform plan then terraform apply. when i did terraform apply it also created terraform state; this will be covered in my notes later on but for now something to understand is that terraform uses state to remember what it manages.

terraform destroy - deletes the managed infrastructure; this is iomportant for avoiding AWS costs, cleaning test environments, and safe experimentation.

CI/CD and security: CI pipelines usually run fmt and validate first; because formatting issues are easy to fix, and validation catches the syntax problems early om- and this is cheaper than failed deployments. this also prevenets broken infrastructure changes.
