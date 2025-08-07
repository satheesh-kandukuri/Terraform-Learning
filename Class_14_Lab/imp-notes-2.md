**```https://wahlnetwork.com/2020/04/29/terraform-plans-modules-and-remote-state/```**

<img width="997" height="330" alt="image" src="https://github.com/user-attachments/assets/cfd8c81d-9cfc-4e4c-9c14-25f90e49a4c0" />

The ```scripts``` are simple human-readable text files that describe the desired deployment architecture. 
Each resource to be deployed will have a section, and each includes the configuration parameters needed to instantiate the resource. 
The deployment architecture can be split over many script files - all held in a single directory. 
Any Terraform command always** runs in the context of your current directory** - often called the Terraform ```root```. 
Remember that any **Terraform will ignore any scripts not in the current directory** - including subdirectories. 
You can name your scripts anything you like as long as they have a ```.tf``` suffix. 
Even ```main.tf``` is not mandatory, although a strong convention.


The first run of the scripts is via the ```Terraform plan``` command. It invokes the Terraform binary to parse the ```scripts``` 
and **build an internal data model of the desired deployment**. 
It then uses that data model to define the set of API calls that would need to be run to deploy the architecture  which it reports back to the user.

Internally, Terraform converts the ```scripts```  files into a **graph model** - this is key to determining the dependencies between resources. 
Terraform uses the graph model to navigate the dependencies and to define the correct order of API calls to deploy the resources.

If the user is happy with the reported plan, then the user can then apply that desired model to the target environment.
At this point, **Terraform will run the API commands against the target environment**. 
If this succeeds, then Terraform stores the final metadata in the ```state file```. 
Thus we then have a digital representation of the deployment.



<img width="1778" height="910" alt="image" src="https://github.com/user-attachments/assets/48f87b3b-797e-4e17-bc7c-e5a9ca122bdf" />
