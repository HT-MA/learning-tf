provider "alicloud" {
  # 阿里云的配置信息
  access_key = "your AK"
  secret_key = "your SK"
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "tf_test_foo"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = "172.16.0.0/21"
  zone_id    = "cn-beijing-b"
}

resource "alicloud_security_group" "default" {
  name   = "default"
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_instance" "example" {
  # ECS 实例配置
  image_id          = "centos_7_9_uefi_x64_20G_alibase_20230816.vhd"
  instance_type    = "ecs.n2.small"  
  availability_zone = "cn-beijing-b"
  security_groups   = alicloud_security_group.default.*.id
  
  internet_max_bandwidth_out  = 1
  host_name                   = "master"
  internet_charge_type        = "PayByTraffic"

  vswitch_id                 = alicloud_vswitch.vsw.id
  password = "password"  # 你的 root 密码
  user_data = <<-EOF
              #!/bin/bash
              cd /root/
              wget https://github.com/easzlab/kubeasz/releases/download/3.5.0/ezdown
              chmod +x ./ezdown
              ./ezdown -D 
              ./ezdown -S 
              docker exec -it kubeasz ezctl start-aio > docker.log 
              source ~/.bashrc
              echo "install complete" > intsall_status.txt
              EOF
}

  
resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}
  

output "instance_id" {
  value = alicloud_instance.example.id
}

output "instance_ip" {
  value = alicloud_instance.example.public_ip
}


