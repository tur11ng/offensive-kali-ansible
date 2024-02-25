{
  "variables": {
    "kali_iso_url": "https://cdimage.kali.org/kali-2023.1/kali-linux-2023.1-installer-amd64.iso",
    "kali_iso_checksum": "sha256_checksum",
    "vm_name": "my-custom-kali"  
  },
  "builders": [
    { 
      "type": "amazon-ebs", 
      "region": "us-east-1",
      "source_ami_filter": {
          "filters": {
              "virtualization-type": "hvm",
              "name": "kali-linux-*-amd64",
              "root-device-type": "ebs"
          },
          "owners": ["amazon"],
          "most_recent": true
      },
      "instance_type": "t2.micro", 
      "ssh_username": "admin", 
      "ami_name": "my-custom-kali-aws {{timestamp}}"
    },
    {
      "type": "virtualbox-iso",
      "guest_os_type": "Debian_64", 
      "iso_url": "{{user `kali_iso_url`}}",
      "iso_checksum": "{{user `kali_iso_checksum`}}",
      "ssh_username": "user", 
      "ssh_password": "password",  
      "output_directory": "output-{{user `vm_name`}}"
    }
  ],
  "provisioners": [ 
    {
      "type": "shell",
      "inline": [ 
        "sudo apt-get update",
        "sudo apt-get install -y python3"  
      ]
    },
    {
      "type": "ansible"
      "playbook_file": "kali_playbook.yml"  
    }
  ]
}
