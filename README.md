This project runs in two differenet environments:

- Build Env
- Dev Env

In build environment  I have used `Launch Configuration` to provision its infrastructure.

In dev environment I have used `Launch Template` along with load balancer.

To run the either of this environments, first clone this repository in your local system using the following url:

  `https://github.com/amir-akhavans/Terraform-AWS-EC2.git`
  
After it is cloned in your system, initialize terraform using command below. This command downloads the provider and plugins data into your local system. you can follow this downloaded plugins through .terraform/plugins
 
  `terraform init`
  
When it is successfuly initialized, you can see the plan it is going to provision using the following command. It should be noted that this command is used to show a preview of what is going to be made when it is applied.

  `terraform plan -auto-approve`
  
In the next step, this previewed plan must be implemented using command apply. This stage provisions the defined resources in the specified cloud environment. To apply the resources, you need to run the following command:

  `terraform apply -auto-approve`
  
It should be noted that during running plan and apply stagesm you will be asked whether you are sure to do it or not. I used `-auto-approve` as YES reply to fuly automate it.

During this stage, some resources may not be correctly provisioned but the message, all the resources are correctly provisioned, shows up at the end. In such situations this resource will be marked as tainted which means it will be provisiond again next time you apply using the command above.  
