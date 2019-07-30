## Synopsis ##

This terraform code allows to create base network, compute and load-balancer infrastructure. It create a simple web server in a load balanced and highly available manner with help of Auto scaling group. The webserver is configured to server two different websites that can be retrieved based on different header.

## Inputs ##
  All the inputs are provided under terraform.tfvars
  
  * aws_region - AWS region to create the resources
  * project_name - AWS project name
  * vpc_cidr - VPC cidr to be created
  * public_cidrs - Subnets to be created
  * accessip - default route to be used
  * key_name - Name of aws key pair
  * public_key_path - path of ssh public key
  * server_instance_type - instance type for EC2 instance

## Outputs ##

  * ALB dns - Load balancer DNS generated
  * Public SG - Public security group id
  * Public Subnets - Public subnets by subnet id
  * Server AMI - AMI name
  * Subnet IPs - Public subnet CIDRs

## Terraform WorkFlow ##
Apart for Inputs required to created resource, AWS credentials are required to 
set prior to starting Terraform workflow

**Step 1.** *set AWS credentials*   
      e.g.    
```export AWS_ACCESS_KEY_ID="AKIA45ONG6SOCJR7SMLY"```  
```export AWS_SECRET_ACCESS_KEY="Sl205XJROQTbNTLnsnKwB7gkonFALygv2zjaHqIQ"```  

**Step 2.** Initialize Terraform providers and modules  
    ```Terraform init```  

**Step 3.** Create the execution plan to deploy the resources and save it file tf_plan  
    ```Terraform plan -out=tf_plan```  

**Step 4.** Apply the changes required to reach the desired state of the configuration   
    ```Terraform apply tf_plan```  

**Step 5.** After use of the environment destroy the Terraform managed infrastructure   
    ```Terraform destroy```  

## Validation Test ##  

* The output received for curl with Header key-value pair of "Host: `www.test.com`" is 'hello test'.
  The output received for curl with Header key-value pair of "Host: `ww2.test.com`" is 'hello test2'.  

```
curl -H "Host: www.test.com"  <ALB dns>

hello test  
curl -H "Host: ww2.test.com" < ALB dns >

hello test2
```


