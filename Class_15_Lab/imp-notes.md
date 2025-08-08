A **``.tfvars``** file in Terraform is used to define input variables for a Terraform configuration. 
It’s a plain text file, typically written in HashiCorp Configuration Language (HCL) or JSON format., 
that contains variable assignments, making it easy to **customize deployments without modifying the core configuration files**
Using a ```tfvars``` file helps keep your configurations reusable and avoids hardcoding values.

Tfvars files allow us to manage variable assignments systematically in a file with the extension **``.tfvars``** or **``.tfvars.json``**

<img width="600" height="450" alt="image" src="https://github.com/user-attachments/assets/9885a93b-ccd6-4d0c-962c-394de1ffa806" />

However, imagine working in multiple environments, such as test, staging, and production. 
We would prefer to deploy a larger instance in production and a smaller instance in the test environment to save money. 
This means that the code remains the same except for the instance type, which varies depending on the environment.

We already know that variables can be used to solve this problem. 
To keep things running, we’ll create a variable for the instance type and set its default value to “t2.micro”.

The above code works but still relies on the default value. What if we want to change the instance type just for the production environment? 
How do we pass it a different value when deploying it to production?

There are numerous ways to accomplish this. 

<img width="898" height="555" alt="image" src="https://github.com/user-attachments/assets/2756ca30-476e-481d-b0c5-54e493f21a4e" />


Sure, both of these methods work. **But imagine typing in values for 10 to 20 variables for 5–10 different environments**! 🤯 

Even if we save the command somewhere, consider **how time-consuming simple changes like changing a few values would be**. 
This is where **``.tfvars``** files come in handy. Terraform can load variable definitions from these files automatically. 

### 💡 Pro tip
- Whenever the number of variables increases significantly, it is wise to break down the project into various small projects.

### Create tfvars files
Let’s assign the variable a value using the terraform.tfvars file.
We will start by creating a file named terraform.tfvars and assigning the instance_type variable a value in this file.

<img width="591" height="234" alt="image" src="https://github.com/user-attachments/assets/3cf87da3-d3fb-471d-bcad-3e31d0d346fd" />

Let’s see if Terraform picks the assigned value in terraform.tfvars file when we run ```terraform plan```
Remember the **default instance_type variable value is t2.micro** and **value assigned in terraform.tfvars file is t2.large**

<img width="901" height="223" alt="image" src="https://github.com/user-attachments/assets/deb34754-f1eb-4898-99b1-862b28a85add" />

### How to manage different versions of variable values for different environments

Some questions to think about:

Should we manually edit the tfvars file every time we deploy to a different environment? 
- Would this solution scale for 10-20 variables with frequent deployments to various environments?
- Continuously updating the tfvars file may become tiresome. 

What if we created multiple files like test.tfvars, staging.tfvars, production.tfvars, and then passed these variables into Terraform at runtime.

<img width="906" height="212" alt="image" src="https://github.com/user-attachments/assets/039a4da2-6bec-48cf-b23c-bfc2971b1617" />


**It picked neither of the versions we defined**; 
it actually went with the t2.micro default value that is assigned to the variable.

### **How do we ask Terraform to use either of our versions then?**

This can be done using the **```-var-file```** flag to specify the **```tfvars```** file to load. 
For instance, to load the production version, we will use the following command.
```hcl
terraform plan -var-file= "prod.tfvars"
```

<img width="800" height="71" alt="image11-2" src="https://github.com/user-attachments/assets/baea1129-15d1-4ff0-b331-38345f44f12d" />


We learned **how to pass values to Terraform variables in a variety of ways** and solved our many to many problems of  **managing multiple variables for many environments**.



Terraform uses **```.tfvars```** files to manage variable assignments, which must be manually loaded with the **```-var-file```** flag unless named **```terraform.tfvars```**

### **```.auto.tfvars```**
An ```.auto.tfvars``` file is automatically loaded by Terraform, making it useful for defining default or environment-specific variables without requiring explicit inclusion in commands.

Terraform auto loads ```tfvars``` files only when they are named ```terraform.tfvars``` or ```terraform.tfvars.json```
Can we ensure that ```tfvars``` files following **custom naming schemes** are **loaded automatically?**

It is possible to **name your file whatever you wish** and have Terraform load it automatically. 
All we have to do is provide the file name with **```.auto.tfvars```** as an extension

We will rename the ```dev.tfvars``` file to ```dev.auto.tfvars``` and run ```terraform plan``` on it. 
The expectation is that Terraform should **automatically pick the value t2.large from the dev.auto.tfvars file instead of the default value t2.micro**.

<img width="563" height="184" alt="image" src="https://github.com/user-attachments/assets/9cd728b7-8333-4696-8a24-d84dec25f823" />

<img width="884" height="340" alt="image" src="https://github.com/user-attachments/assets/18f59d58-43f1-4036-a72d-36b57aa6a5c6" />


### 💡 Pro tip: Should TFvars be committed?

- ```tfvars``` files should generally **not be committed to version control**,
  especially if they contain sensitive information such as credentials, API keys, or other secrets. 
  These files are used to define variable values for Terraform configurations, and **storing them in a repository can expose sensitive data**.
- If ```tfvars``` files must be included for non-sensitive default values, ensure that **sensitive information is excluded** 
  and use **```.gitignore```** to prevent accidental commits of confidential data.


### **Variable loading precedence**
An interesting thing to ponder is the precedence of the various methods of providing variable values.
  <img width="511" height="421" alt="image" src="https://github.com/user-attachments/assets/224be665-712b-4a40-bd2b-db798533ff29" />
