# Load YAML and decrypt the secrets file
require 'yaml'
decrypted_secrets = YAML.safe_load(`ansible-vault decrypt secrets.yml`)

Vagrant.configure("2") do |config|
  config.vm.define "kali_virtualbox" do |vbox|
    vbox.vm.box = "kalilinux/rolling"
    vbox.vm.provider :virtualbox do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
    vbox.vm.hostname = "kali-virtualbox"
  end

  # Configuration for Azure
  config.vm.define "kali_azure" do |azure|
    azure.vm.box = "kalilinux/rolling"
    azure.vm.provider :azure do |azure_provider, override|
      override.ssh.username = "kali"
      override.vm.hostname = "kali-azure"

      azure_provider.tenant_id = decrypted_secrets['azure_tenant_id']
      azure_provider.client_id = decrypted_secrets['azure_client_id']
      azure_provider.client_secret = decrypted_secrets['azure_client_secret']
      azure_provider.subscription_id = decrypted_secrets['azure_subscription_id']
      azure_provider.resource_group_name = "YOUR_RESOURCE_GROUP_NAME"
      azure_provider.vm_name = "kali-azure"
      azure_provider.vm_size = "Standard_B1ls"
      azure_provider.location = "eastus"
    end
  end

  # Configuration for AWS
  config.vm.define "kali_aws" do |aws|
    aws.vm.box = "kalilinux/rolling"
    aws.vm.provider :aws do |aws_provider, override|
      override.ssh.username = "kali"
      override.ssh.private_key_path = "/path/to/your/private_key.pem"

      aws_provider.access_key_id = decrypted_secrets['aws_access_key_id']
      aws_provider.secret_access_key = decrypted_secrets['aws_secret_access_key']
      aws_provider.region = "us-east-1"
      aws_provider.security_groups = ["YOUR_SECURITY_GROUP"]
      aws_provider.instance_type = "t2.micro"
      aws_provider.ami = "ami-0f4507b919f8fe6b0" # Kali Linux AMI
    end
  end
end
