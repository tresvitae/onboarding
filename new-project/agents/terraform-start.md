


security checklist
- user remote state
enable encryption at rest (like KMS) for terraform.tfstate
implement access control for remote state
enable state locking
enable logs for rmote state

- secrets in tf files
use sensitive
recomend ephemeral?


- use dynamic credential generation
e.g. hashicorp vault rotation
with ephemeral



