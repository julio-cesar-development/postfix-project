# Postfix and Mailhog Project

![License](https://badgen.net/badge/license/MIT/blue)

> This is a simple project to try out Postfix to send a sample email using Mailhog.<br>

---

## Instructions

> Running

```bash
docker-compose up -d mailhog
docker-compose logs -f postfix

docker-compose up -d --build postfix
docker-compose logs -f postfix

docker-compose up -d --build app
docker-compose logs -f app
```
