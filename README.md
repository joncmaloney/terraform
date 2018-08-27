

Requirements
------------

-	[Terraform](https://www.terraform.io/downloads.html) 0.10.x


Special Thanks
---------------
https://github.com/clstokes/example-terraform-bastion


Using this repository
----------------------

```sh
$ git clone https://github.com/joncmaloney/terraform.git
```

Adding your own AWS access key and secret
------------------------------------------

You will need to get your own AWS keys. I've placed my keys in secret-vars.tf and then added this file to .gitignore so it doesn't appear in the source control. 

Once you have cloned this repository make the file and add your keys. 

```sh
$ nano secret-vars.tf
```

Copy and paste the following then replace the access key and secret with your own.
```tf
variable "aws_access_key" {
  default = "XXXXXXXXXXXXXXXXXXXXX"
}

variable "aws_secret_key" {
  default = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
```

Adding your own private key
------------------------------------------

I have placed my keys in '../' if your my key is also called jumphost this code will work for you. However you might need to place the name and path of your keys into the file keys.tf

```sh
$ nano keys.tf
```

```tf
variable "bastion_key_path" {
  default = "{PATH_TO_YOUR_PRIVATE_KEY}.pem"
}

variable "bastion_key_name" {
  default = "{YOUR_KEY_NAME}"
}
```

Initialise and apply terraform
-------------------------------

Once you have cloned the git repo, applied the changes described above you are then all set to run terraform. 

First initialise terraform so it can download and install plugins. 

```sh
$ terraform init
```

Then apply configuration to your infrastructure. 

```sh
$ terraform apply
```