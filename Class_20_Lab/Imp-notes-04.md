## OpenTofu and Terraform

<img width="1007" height="410" alt="image" src="https://github.com/user-attachments/assets/d58a1a21-e0f2-4039-b509-be675351b091" />

<img width="999" height="392" alt="image" src="https://github.com/user-attachments/assets/d0476890-d597-4edc-a9db-a99260a76a16" />

<img width="1043" height="475" alt="image" src="https://github.com/user-attachments/assets/a13494d7-3d88-4511-9a85-9ee4d16ff05c" />


### Installing OpenTofu in Windows

```powershell
winget install --exact --id=OpenTofu.Tofu
```


<img width="1043" height="71" alt="image" src="https://github.com/user-attachments/assets/bcb00d51-ad67-47f8-9cd9-71e0544c1521" />

<img width="1011" height="631" alt="image" src="https://github.com/user-attachments/assets/ca8c1802-8e3a-4d76-b3da-eb5a9734edad" />

```hcl
# resources going to create in aws using OpenTofu

resource "aws_instance" "test" {
  ami           = "ami-00ca32bbc84273381"
  instance_type = "t3.micro"

  tags = {
    Name = local.Name
    Environment = local.Environment
    Project = local.Project
  }
}


locals {
  Name = "Open_Tofu"
  Environment = var.tags["Environment"]
  Project = var.tags["Project"]
}


variable "tags" {
  type = map(string)
  default = {
    Name = "Open_Tofu"
    Environment = "Test"
    Project = "tofu_project"
  }
}
```

<img width="1156" height="658" alt="image" src="https://github.com/user-attachments/assets/5301695d-cd47-4077-ba6f-ec8ce090ad03" />

<img width="942" height="742" alt="image" src="https://github.com/user-attachments/assets/dea642ce-3d90-43ff-99ae-7e0619e3654a" />

<img width="1216" height="515" alt="image" src="https://github.com/user-attachments/assets/2775b313-e618-476e-91b4-390a94381587" />

<img width="1235" height="733" alt="image" src="https://github.com/user-attachments/assets/597faf2e-4e5b-467f-bfa5-2917fc4c6a5a" />
