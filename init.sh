#!/bin/bash

# 更新软件包索引
sudo apt update

# 安装依赖软件包以便通过 HTTPS 使用存储库
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release

# 安装 Docker

# 添加 Docker 的官方 GPG 密钥
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 添加 Docker 的 APT 存储库
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 更新软件包索引
sudo apt update

# 安装 Docker 引擎
sudo apt install -y docker-ce docker-ce-cli containerd.io

# 启动 Docker 并设置开机自启动
sudo systemctl start docker
sudo systemctl enable docker

# 安装 Terraform

# 下载 Terraform 的最新版本
TERRAFORM_VERSION="1.8.2"
curl -LO "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

# 解压下载的包
sudo apt install -y unzip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# 将 Terraform 二进制文件移动到 /usr/local/bin 目录
sudo mv terraform /usr/local/bin/

# 清理安装文件
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# 验证安装

# 验证 Docker 安装
sudo docker run hello-world

# 验证 Terraform 安装
terraform -v

echo "Docker 和 Terraform 已成功安装"