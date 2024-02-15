🟢 Light:
〰️〰️〰️〰️〰️〰️〰️〰️
1. Разверните виртуальную машины с linux: game01. Можно использовать любые способы создания, например в Яндекс Облаке или локально на Vagrant
2. Установите и настройте nginx на виртуальную машину “game01”. Настроить сервер в качестве proxy на localhost
3. Разверните на виртуальной машину Игру и настройте nginx для открытия сайта с игрой
4. Создайте linux system unit отвечающий за запуска сервиса с игрой
5. Сделайте простейшую автоматизацию для настройки сервера: bash-скрипты либо vagrant provisioning


В репозитории Vagrantfile и скрипт site-config.sh, который склонирует репозитории на ВМ и установит все необходимые приложения
Для запуска: 

git clone https://github.com/makeevevgeny/deus-240126-2048-game.git
Переходим в папку с игрой
Чтобы скачать ubuntu box для вагранта, потребуется впн 
vagrant up
Игра должна быть доступна на localhost:8888




🟡 Normal:
〰️〰️〰️〰️〰️〰️〰️〰️
1. Написать Dockerfile для игры (проект использует node16), нужно сделать образ легковесным через мультистейджинг
2. Установить на “game01” Docker и запустить игру в контейнере. Настроить работу контейнера без внешнего nginx
3. Написать gitlab-ci пайплайн для автоматической сборки и публикации Docker-образа с приложением
4. Написать ansible-роль “docker”, для установки docker. Роль должна проходить тесты molecule
5. Написать ansible-playbook настраивающий сервер game01, как в уровне Light-5, и темплейт system unit запускающий docker-контейнер с нужным нам приложением
6. Добавить в gitlab-ci шаг с деплоем приложения на сервера. Ansible-роли должны находиться в отдельных репозиториях и работать через ansible-galaxy
7. Увеличить количество серверов до трёх и настроить распределение входящих запросов через haproxy


1. В папке, склонированной ранее на уровне Light, есть Dockerfile, соберем его

- creating  docker image:

docker build -t 2048-game .

Полученный образ - легковесный 
2048-game             latest            66495a288dfe   5 days ago      42.7MB

- running container:

docker run -d --name 2048-game-container -p 12000:80 \
 -v $(pwd)/default.conf:/etc/nginx/conf.d/default.conf 2048-game

default.conf is included to the repo:

server {
  listen 80 default;
  server_name _;
  root /var/www/myapp;
  index index.html;
}

Игра должна быть доступна на localhost:12000

2. папка normal_2
- запускаем vagrant up
Будет запущена ВМ в виртуалбокс - простой ubuntu, внетри нее докер контейнер с игрой
Имадж загружен в докерхаб docker pull evgeniimakeev/2048-game-docker-based-wo-ext-nginx:latest

# Overview

Sample javascript application implementing the classic [2048 game](https://en.wikipedia.org/wiki/2048_(video_game)). Main project is based on the [game-2048 library](https://www.npmjs.com/package/game-2048) and [Webpack](https://webpack.js.org).

## Requirements  
node 16

## Building the 2048 Game Application

Main project is `javascript` based, hence you can build the application via `npm`:

```shell
npm install --include=dev

npm run build
```

You can test the application locally, by running below command:

```shell
npm start
```

Above command will start a web server in development mode, which you can access at [localhost:8080](http://localhost:8080). Please visit the main library [configuration](https://www.npmjs.com/package/game-2048#config) section from the public npm registry to see all available options.

Open a web browser and point to [localhost:8080](http://localhost:8080/). You should see the `game-2048` welcome page:

![2048 Game Welcome Page](assets/images/game-2048-welcome-page.png)
# deus-240126-2048-game
