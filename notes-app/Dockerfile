#BUILD STAGE
FROM cgr.dev/garrett.crosby/python:3.13-dev@sha256:f9fac3f1cc7ae17fa44f05c0ef9b835f0a2140e87d57cbf2343bd7d603687163 as build
USER root
ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN python -m venv /note-app/venv
ENV PATH="/note-app/venv/bin:$PATH"

WORKDIR /note-app

RUN apk add zlib-dev libjpeg-turbo libjpeg-turbo-dev
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# FINAL STAGE
FROM cgr.dev/garrett.crosby/python:3.13@sha256:9393d46e46fb1dcf30e14af8b59fe75228c349c1be49e62cf83102c597c97388
USER root
WORKDIR /note-app

ENV PYTHONBUFFERED 1

COPY --from=build /note-app/venv /note-app/venv
COPY --from=build /usr/lib/libjpeg.so.8 /usr/lib/libjpeg.so.8

ENV PATH "/note-app/venv/bin:$PATH"
COPY . .
ENTRYPOINT ["python", "/note-app/manage.py", "runserver", "0.0.0.0:8000"]
