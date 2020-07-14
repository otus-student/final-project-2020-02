[![Build Status](https://travis-ci.com/otus-student/final-project-2020-02.svg?token=W4i6p9bHAU888Up6r7WS&branch=master)](https://travis-ci.com/otus-student/final-project-2020-02)

# final-project-2020-02
Final project (group 2020-02)

Процент выполнения проекта ~50%

# Содержание проекта

### Папка src

#### подпапка rabbitmq
Содержит [конфигурацию](src/rabbitmq/rabbitmq.conf) и [докер-файл](src/rabbitmq/Dockerfile) для создания образа приложения rabbitmq

#### подпапка search_engine_crawler
Содержит код нашего приложения (бота), тесты, скрипт [crawler_entrypoint.sh](src/search_engine_crawler/crawler_entrypoint.sh) и [докер-файл](src/search_engine_crawler/Dockerfile) для создания образа бекенда приложения
> Скрипт необходим, чтобы при деплое всех частей приложения, бекенд ждал деплоя rabbitmq и потом начаинал свою работу

#### подпапка search_engine_ui
Содержит код нашего приложения (веб-интерфейс), тесты и [докер-файл](src/search_engine_ui/Dockerfile) для создания образа фронтенда приложения

### Папка monitoring
Содержит папки с файлами конфигураций и докер-файлами для сборки образов приложений мониторинга нашего приложения

### Папка docker
Содержит файлы [docker-compose](docker/docker-compose.yml) для создания докер контейнеров для работы нашего приложения и его [мониторинга]((docker/docker-compose-monitoring.yml)), а также файлы конфигурации переменных

### Папка infra

#### подпапка terraform
Содержит описание создания инфраструктуры для нашего приложения: создание ВМ для хранения кода и CI/CD, создание сети и настройки фаервола.

#### подпапка ansible
Содержит описание установки ПО для подготовки нашей инфраструктуры к использованию CI/CD: установка Gitlab CI, установка docker и регистрация раннеров Gitlab CI

# Предварительные требования для запуска проекта:

- Аккаунт в Google Cloud Platform
- Установленный Terraform
- Установленный Ansible

# Как запустить проект

1. Из корня репозитория выполнить, для создания ВМ

```
make install_gitlab_stage_infra
```

2. Из корня репозитория выполнить, для задания временной переменной адреса сервера Gitlab CI

```
cd ./infra/terraform/stage && export GITLAB_IP=$(terraform output -json | jq .gitlab_ci_external_ip.value -r)
```

3. Из корня репозитория выполнить, для установки Gitlab CI

```
make install_gitlab_stage_software
```

4. Перейти на адрес нашего сервера Gitlab, ввести пароль, создать новый проект и группу, скопировать токен для раннеров и выполнить

```
export GITLAB_RUNNER_TOKEN=токен
```

5. Из корня репозитория выполнить, для создания и регистрации раннера

```
make register_gitlab_runner
```

6. Из корня репозитория выполнить, для установки docker

```
make install_docker_on_hosts
```

7. Запушить репозиторий в Gitlab CI

```
git remote add gitlab http://адрес-вашего-гитлаб/ваша-гитлаб-группа/ваш-гитлаб-проект.git
```

8. Добавить переменные в Gitlab CI и отключить им защиту

- DOCKER_HUB_PASSWORD (пароль Вашего докерхаб пользователя)
- DOCKER_HUB_USER (имя Вашего докерхаб пользователя)
- PROJECT_HUB (логин Вашего докерхаб пользователя)

9. Запустить пайплайн, дождаться успешного деплоя приложения и проверить по адресу вашего Gitlab CI сервера на порту 8000

TO BE CONTINUED...
