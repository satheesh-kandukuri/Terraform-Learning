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

🟩 **Top-Level Blocks (Keywords)**
Most of Terraform's features are implemented as top-level blocks including:

- resource - Defines infrastructure resources (compute instances, networks, etc.)
- data - Fetches information from existing resources outside your configuration
- variable - Declares input variables for customization
- output - Defines return values from a Terraform module
- locals - Defines local values for reuse within a configuration
- module - Calls and configures child modules
- provider - Configures provider plugins
- terraform - Contains Terraform settings and requirements


🟦 **Resource Meta-Arguments (Special inside resource blocks)**
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


🟨 **Built-in Functions (Internal function names)**
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
