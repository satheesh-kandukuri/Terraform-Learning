<img width="909" height="355" alt="image" src="https://github.com/user-attachments/assets/0e0bdcf9-f98b-4d55-bf69-6fcb867f7424" />

-----------------------------------------------------------------------------------------------------------------------------------

<img width="981" height="542" alt="image" src="https://github.com/user-attachments/assets/b65d890e-7665-4c57-86c2-d21af6f0a426" />

-----------------------------------------------------------------------------------------------------------------------------------

<img width="918" height="685" alt="image" src="https://github.com/user-attachments/assets/4600b1a4-5bdf-4990-ac1b-9c721d83318b" />


### 🔎 Terraform Debugging Guide

### 1. Basic Debugging Approaches
Before going deep, **always start simple**:
- Check syntax
```hcl
terraform validate
```
Ensures your .tf files are syntactically correct.

- Check plan output
```hcl
terraform plan
```
Shows what changes Terraform will make.
Look for unexpected additions, deletions, or modifications.

### 2. Terraform Logging & Debug Modes
Terraform has built-in logging that can be enabled with the TF_LOG environment variable.

**Log Levels**

Set before running Terraform commands:
```bash
export TF_LOG=TRACE    # Most detailed
export TF_LOG=DEBUG    # Debug info
export TF_LOG=INFO     # Normal operation
export TF_LOG=WARN     # Warnings only
export TF_LOG=ERROR    # Errors only
```

Set the ```TF_LOG``` variable

Terraform has detailed logs that you can enable by setting the ```TF_LOG``` environment variable to any value. 
You can set ```TF_LOG``` to one of the log levels (in order of decreasing verbosity) 
- TRACE
- DEBUG
- INFO
- WARN 
- ERROR to change the verbosity of the logs.

- For Windows (PowerShell):
```powershell
$env:TF_LOG="DEBUG"
```
👉 Use ```TRACE``` for the deepest debugging (**shows provider calls, API requests, etc.**) — but it will be very verbose.


### 3. Debugging Provider & API Issues

Many problems happen at the provider layer (e.g., AWS, Azure, GCP).

Run with detailed trace logs:
```hcl
TF_LOG=TRACE terraform apply
```
This shows API requests/responses between Terraform and the cloud provider.

### 4. Terraform Console for Debugging

Terraform has an interactive REPL called ```terraform console```
It’s extremely useful for inspecting variables, outputs, and expressions.
```hcl
terraform console
> var.vpc_id
"vpc-123456"
> aws_vpc.main.id
"vpc-123456"
```
You can debug:
- Whether variables are being passed correctly
- How locals are evaluated
- What data sources return

<img width="791" height="466" alt="image" src="https://github.com/user-attachments/assets/9fa0b1ea-aee1-4cb5-bf8f-c2ce2f36ece2" />
