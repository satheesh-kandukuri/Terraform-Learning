- Jenkins - XML 
- Kubernetes - YAML
- CloudFormatin - JSON

```hcl
variable "Availability_Zone" {
  description = "Availability Zone for the AWS instance"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
```
When you define a variable of type map(string) (or any map type) **without a default**, 
it becomes required — **you must pass a value for it at runtime**.
If you provide a default, then Terraform will use that value unless overridden.


In Terraform, **internal keywords** (also referred to as reserved words or built-in language constructs) 
are part of the Terraform configuration language (HCL - HashiCorp Configuration Language). 
These **cannot be used as variable names, resource names, or identifiers**, because they have special meaning in the language.

and using them as names will cause syntax errors or unexpected behavior:

Here’s a categorized list of Terraform internal keywords and built-in constructs:

### 🟩 **Top-Level Blocks (Keywords)**
Most of Terraform's features are implemented as top-level blocks including:

- resource - Defines infrastructure resources (compute instances, networks, etc.)
- data - Fetches information from existing resources outside your configuration
- variable - Declares input variables for customization
- output - Defines return values from a Terraform module
- locals - Defines local values for reuse within a configuration
- module - Calls and configures child modules
- provider - Configures provider plugins
- terraform - Contains Terraform settings and requirements


### 🟦 **Resource Meta-Arguments (Special inside resource blocks)**
These are internal keywords that configure the behavior of resources:

- count - Creates multiple instances of a resource
- for_each - Creates instances based on a map or set
- provider
- depends_on - Explicitly declares dependencies
- lifecycle (and its sub-blocks: create_before_destroy, prevent_destroy, ignore_changes)
- provisioner - Selects a non-default provider configuration
- connection
- source
- version


HCL Language Constructs

- if / else - Conditional expressions
- for - For expressions and loops
- dynamic - Dynamic block generation
- null - Represents absence of a value
- true / false - Boolean literals


### 🟨 **Built-in Functions (Internal function names)**
Terraform includes many built-in functions (don’t use these as variable names):

- length()
- lookup()
- join()
- split()
- merge()
- toset()
- tolist()
- file()
- upper()
- lower()
- replace()
- regex()
- flatten()
- zipmap()


Terraform defined the following arguments to be used inside the ```variable``` block:

- type
- default
- description
- validation
- sensitive
- nullable


The validation block in Terraform is very important because it helps enforce input correctness and safety before Terraform applies any changes to your infrastructure.

### ✅ What is the validation block?
The ```validation``` block is used inside a ```variable``` block to define custom rules for acceptable input values. If the condition fails, Terraform throws an error early, preventing misconfiguration.

### 🎯 Why is it important?
- Catches User Input Errors Early
Prevents invalid values (e.g., an empty AMI ID, an incorrect region name, or an invalid CIDR block) from reaching the Terraform plan or apply stage.

- Avoids Infrastructure Misconfiguration
Example: Ensuring an EC2 instance is only deployed in allowed regions or with allowed instance types.

- Improves User Experience / Guides users
Gives clear, custom error messages so the user knows exactly what went wrong and how to fix it.

- Improves Security / Encourages standards
Prevents unsafe values (e.g., public CIDRs, default passwords, or unrestricted ports) from being used accidentally.

### ❗ Important Notes:
- validation only works on input variables (not locals, resources, etc.).
- Must return a boolean expression (true or false).
- You can use any Terraform expression functions (length(), substr(), contains(), etc.).

### ✅ Best Practices:
- Use ```validation``` to **catch errors early**.
- Always write **clear, helpful** ```error_messages```.
- Keep conditions **simple and readable**.

  
the validation block inside a variable is used to **enforce custom rules on the input value**. 
The core part of this block is the ```condition```

### 🔍 What is condition?
- It's a Terraform expression that must evaluate to either ```true``` or ```false```.
- If it returns ```true```, input is accepted.
- If it returns ```false```, Terraform throws an error with the given ```error_message```.


🧠 You Can Use:
- Logical operators: ```==```, ```!=```, ```>```, ```<```, ```&&```, ```||```
- Terraform functions: ```length()```, ```contains()```, ```substr()```, ```regex()```, ```can()```, etc.
- Variables: referenced as ```var.variable_name```


ex: Restrict to allowed instance types:
```hcl
condition     = contains(["t2.micro", "t3.small"], var.instance_type)
error_message = "Only t2.micro and t3.small are allowed."
```
<img width="1042" height="412" alt="image" src="https://github.com/user-attachments/assets/dc9f5971-4248-48fb-87d3-0bac4f5e49e5" />

