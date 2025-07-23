#BUILD STAGE
FROM cgr.dev/garrett.crosby/python:3.13-dev@sha256:1e8c9051bae4ffdd01a0a81b8dc9cc31cfe93ec9042a5a709af9a6d52a1da50d as build
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
FROM cgr.dev/garrett.crosby/python:3.13@sha256:8e5cd207e7ce6cc5bb8d8c987390aae38f2264d311c831af6ebac2ec9cd847e3
USER root
WORKDIR /note-app

ENV PYTHONBUFFERED 1

COPY --from=build /note-app/venv /note-app/venv
COPY --from=build /usr/lib/libjpeg.so.8 /usr/lib/libjpeg.so.8

ENV PATH "/note-app/venv/bin:$PATH"
COPY . .
ENTRYPOINT ["python", "/note-app/manage.py", "runserver", "0.0.0.0:8000"]
