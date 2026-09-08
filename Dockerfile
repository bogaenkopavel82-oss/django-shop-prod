# Базовый образ с Python
FROM python:3.12-slim

# Отключаем буферизацию вывода Python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем файл с зависимостями и устанавливаем их
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Создаём папки для логов и медиафайлов
RUN mkdir -p /app/logs /app/media /app/static

# Копируем весь проект
COPY . /app/

# Открываем порт 8000
EXPOSE 8000

# Запускаем Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "--access-logfile", "/app/logs/gunicorn_access.log", "--error-logfile", "/app/logs/gunicorn_error.log", "mysite.wsgi:application"]