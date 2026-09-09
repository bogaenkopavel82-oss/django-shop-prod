# Базовый образ с Python
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /app/logs /app/media /app/static

COPY . /app/

WORKDIR /app/mysite

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "--access-logfile", "/app/logs/gunicorn_access.log", "--error-logfile", "/app/logs/gunicorn_error.log", "mysite.wsgi:application"]
