# Лабораторна робота № 3
## Розгортання та налаштування хмарного середовища за допомогою Terraform

> **Мета роботи:** Отримати навички роботи з Terraform для створення та управління хмарною інфраструктурою.

---

## Опис проєкту

Цей проєкт демонструє розгортання хмарної інфраструктури на платформі **AWS** за допомогою інструменту **Terraform** — відкритого інструменту для декларативного управління інфраструктурою як кодом (Infrastructure as Code, IaC).

У рамках лабораторної роботи розгортається:
- VPC з двома публічними підмережами у різних зонах доступності
- Internet Gateway та таблиця маршрутизації
- Security Group з обмеженим SSH-доступом та кастомним веб-портом
- EC2 інстанс (Ubuntu 24.04 LTS) з автоматичним розгортанням Apache2
- Remote backend на базі S3 для зберігання Terraform state

---

## Prerequisites (Передумови)

### 1. Terraform
Версія: `>= 1.10.0`

Встановлення (Ubuntu/Debian):
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | \
  sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

Перевірка:
```bash
terraform -version
```

### 2. AWS CLI
Встановлення (Ubuntu/Debian):
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

Перевірка:
```bash
aws --version
```

Налаштування облікових даних:
```bash
aws configure
# AWS Access Key ID:     <ваш ключ>
# AWS Secret Access Key: <ваш секрет>
# Default region name:   eu-central-1
# Default output format: json
```

### 3. Додаткові інструменти

| Інструмент | Версія   | Призначення                      |
|------------|----------|----------------------------------|
| Git        | >= 2.x   | Клонування репозиторію           |
| AWS CLI    | >= 2.x   | Автентифікація та керування AWS  |
| unzip      | будь-яка | Розпакування AWS CLI інсталятора |

---

## Структура проєкту

```
.
├── .gitignore       # Ігнорування tfvars, state, .terraform/
├── README.md        # Документація проєкту
├── backend.tf       # Конфігурація S3 remote backend
├── bootstrap.sh     # Скрипт ініціалізації EC2 (Apache2)
├── main.tf          # Основна конфігурація ресурсів AWS
├── outputs.tf       # Вихідні значення після розгортання
├── providers.tf     # Terraform та AWS провайдери
└── variables.tf     # Оголошення змінних
```

> ⚠️ Файл `terraform.tfvars` **не додається до git** — містить індивідуальні значення змінних.

---

## Інструкції з використання

### `terraform init` — Ініціалізація проєкту

Завантажує провайдери (`hashicorp/aws`, `hashicorp/http`) та підключає S3 backend.

```bash
terraform init
```

Очікуваний результат:
```
Initializing the backend...
Initializing provider plugins...
Terraform has been successfully initialized!
```

---

### `terraform apply` — Розгортання інфраструктури

```bash
terraform apply
```

Terraform покаже план змін і запросить підтвердження — введіть `yes`.

Для попереднього перегляду без змін:
```bash
terraform plan
```

Очікуваний результат:
```
Plan: 9 to add, 0 to change, 0 to destroy.
Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:
  ec2_public_ip = "X.X.X.X"
  website_url   = "http://X.X.X.X:8080"
```

---

### `terraform destroy` — Видалення інфраструктури

```bash
terraform destroy
```

> ⚠️ **Увага:** Операція незворотна — всі AWS ресурси будуть видалені. Виконуйте після завершення роботи, щоб уникнути зайвих витрат.

Очікуваний результат:
```
Destroy complete! Resources: 9 destroyed.
```

---

## Типовий робочий процес

```bash
# 1. Клонувати репозиторій
git clone https://github.com/Fradid/cloud-tech.git
cd cloud-tech

# 2. Створити файл змінних
cp terraform.tfvars.example terraform.tfvars
# відредагувати terraform.tfvars під свій варіант

# 3. Ініціалізувати Terraform
terraform init

# 4. Переглянути план
terraform plan

# 5. Розгорнути інфраструктуру
terraform apply

# 6. Після завершення роботи — видалити ресурси
terraform destroy
```

---

## Автор

**Виконав:** *Bohdan Klochko*  
**Група:** *OI-31sp*  
**Дата виконання:** *15.03.2026*