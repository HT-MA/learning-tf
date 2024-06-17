

```markdown
# Terraform 学习项目

这是一个用于学习和实践 [Terraform](https://www.terraform.io/) 的仓库。Terraform 是一种开源的基础设施即代码（Infrastructure as Code, IaC）工具，允许用户通过高层次的配置语言来定义和提供数据中心基础设施。

## 目录

- [项目简介](#项目简介)
- [安装](#安装)
- [使用方法](#使用方法)
- [目录结构](#目录结构)
- [示例](#示例)
- [资源](#资源)
- [贡献](#贡献)
- [许可证](#许可证)

## 项目简介

本项目包含多个 Terraform 配置文件和示例，旨在帮助用户理解如何使用 Terraform 创建和管理云基础设施。通过这些示例，您将学习如何：

- 定义基础设施资源
- 使用变量和输出
- 管理状态文件
- 模块化配置

## 安装

在开始之前，请确保您的系统已安装以下软件：

1. [Terraform](https://www.terraform.io/downloads.html)
2. [Git](https://git-scm.com/downloads)

安装 Terraform：

```bash
# 下载并安装 Terraform
wget https://releases.hashicorp.com/terraform/1.0.0/terraform_1.0.0_linux_amd64.zip
unzip terraform_1.0.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

验证安装是否成功：

```bash
terraform -v
# Terraform v1.0.0
```

## 使用方法

1. 克隆仓库：

```bash
git clone https://github.com/your-username/terraform-learning-repo.git
cd terraform-learning-repo
```

2. 初始化 Terraform：

```bash
terraform init
```

3. 查看计划：

```bash
terraform plan
```

4. 应用配置：

```bash
terraform apply
```

5. 销毁资源：

```bash
terraform destroy
```

## 目录结构

```
terraform-learning-repo/
├── main.tf              # 主要的 Terraform 配置文件
├── variables.tf         # 变量定义文件
├── outputs.tf           # 输出定义文件
├── modules/             # 模块目录
│   └── example-module/  # 示例模块
├── examples/            # 示例配置
│   └── example1/        # 示例1
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md            # 项目说明文件
```

## 示例

### 示例1: 简单的 EC2 实例

```hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

使用以下命令运行示例：

```bash
cd examples/example1
terraform init
terraform apply
```

## 资源

- [Terraform 官方文档](https://www.terraform.io/docs)
- [Terraform GitHub 仓库](https://github.com/hashicorp/terraform)
- [Terraform 学习指南](https://learn.hashicorp.com/terraform)

## 贡献

欢迎贡献！如果你有任何改进建议或发现了问题，请提交一个 Issue 或创建一个 Pull Request。

## 许可证

本项目采用 [MIT 许可证](LICENSE)。

