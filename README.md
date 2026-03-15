# Лабораторна робота № 3
## Розгортання та налаштування хмарного середовища за допомогою Terraform

> **Мета роботи:** Отримати навички роботи з Terraform для створення та управління хмарною інфраструктурою.

---

## Опис проєкту

Цей проєкт демонструє розгортання хмарної інфраструктури за допомогою інструменту **Terraform** — відкритого інструменту для декларативного управління інфраструктурою як кодом (Infrastructure as Code, IaC).

У рамках лабораторної роботи виконується:
- Ініціалізація Terraform-проєкту та завантаження необхідних провайдерів
- Опис бажаного стану інфраструктури у конфігураційних файлах (`.tf`)
- Розгортання хмарних ресурсів за допомогою команди `apply`
- Видалення створених ресурсів командою `destroy`

---

## Prerequisites (Передумови)

Перед початком роботи переконайтесь, що на вашій машині встановлено та налаштовано наступне:

### 1. Terraform
Версія: `>= 1.0.0`

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

Перевірка встановлення:
```bash
terraform -version
```

### 2. Обліковий запис хмарного провайдера
- Активний акаунт у хмарному провайдері (AWS / GCP / Azure тощо)
- Налаштовані облікові дані (credentials) для автентифікації

Приклад для AWS (через AWS CLI):
```bash
aws configure
# Введіть: AWS Access Key ID, Secret Access Key, регіон, формат виводу
```

### 3. Додаткові інструменти
| Інструмент | Версія | Призначення |
|---|---|---|
| Git | >= 2.x | Клонування репозиторію |
| AWS CLI / gcloud / az | остання | Автентифікація у провайдера |

---

## Структура проєкту

```
.
├── main.tf           # Основна конфігурація ресурсів
├── variables.tf      # Оголошення змінних
├── outputs.tf        # Вихідні значення після розгортання
├── terraform.tfvars  # Значення змінних (не додавати до git!)
└── README.md         # Документація проєкту
```

---

## Інструкції з використання

### `terraform init` — Ініціалізація проєкту

Команда завантажує необхідні провайдери та модулі, зазначені у конфігурації. Виконується **один раз** перед першим використанням або після зміни провайдерів.

```bash
terraform init
```

**Що відбувається:**
- Завантажуються плагіни провайдерів (наприклад, `hashicorp/aws`)
- Ініціалізується локальний backend для зберігання стану (`terraform.tfstate`)
- Завантажуються зовнішні модулі (якщо використовуються)

**Очікуваний результат:**
```
Initializing the backend...
Initializing provider plugins...
Terraform has been successfully initialized!
```

---

### `terraform apply` — Розгортання інфраструктури

Команда аналізує конфігурацію, формує план змін та застосовує їх — створює або оновлює хмарні ресурси.

```bash
terraform apply
```

Terraform відобразить план змін і запросить підтвердження. Введіть `yes` для продовження.

Для автоматичного підтвердження (наприклад, у CI/CD):
```bash
terraform apply -auto-approve
```

Для попереднього перегляду плану без внесення змін:
```bash
terraform plan
```

**Очікуваний результат:**
```
Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Enter a value: yes

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

---

### `terraform destroy` — Видалення інфраструктури

Команда видаляє **всі** ресурси, описані у конфігурації та зафіксовані у файлі стану.

```bash
terraform destroy
```

Terraform відобразить список ресурсів, що будуть видалені, та запросить підтвердження. Введіть `yes` для продовження.

> ⚠️ **Увага:** Ця операція є незворотною. Всі дані та ресурси будуть безповоротно видалені.

Для автоматичного підтвердження:
```bash
terraform destroy -auto-approve
```

**Очікуваний результат:**
```
Plan: 0 to add, 0 to change, 3 to destroy.

Do you want to perform these actions?
  Enter a value: yes

Destroy complete! Resources: 3 destroyed.
```

---

## Типовий робочий процес

```bash
# 1. Клонувати репозиторій
git clone <url-репозиторію>
cd <назва-папки>

# 2. Ініціалізувати Terraform
terraform init

# 3. Переглянути план змін
terraform plan

# 4. Розгорнути інфраструктуру
terraform apply

# 5. Після завершення роботи — видалити ресурси
terraform destroy
```

---

## Автор

**Виконав:** *(ПІБ студента)*  
**Група:** *(назва групи)*  
**Дата виконання:** *(дата)*