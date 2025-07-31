#BUILD STAGE
FROM cgr.dev/garrett.crosby/python:3.13-dev@sha256:889537ec13e5fa2084dbea9a21e7dc61e408dc7c51513fd31c6dafb7e3093224 as build
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
FROM cgr.dev/garrett.crosby/python:3.13@sha256:42f3b2e5b7d0d095b70b82f9bd8eebce88c0df591b083c71faa9fe52c170cfd2
USER root
WORKDIR /note-app

ENV PYTHONBUFFERED 1

COPY --from=build /note-app/venv /note-app/venv
COPY --from=build /usr/lib/libjpeg.so.8 /usr/lib/libjpeg.so.8

ENV PATH "/note-app/venv/bin:$PATH"
COPY . .
ENTRYPOINT ["python", "/note-app/manage.py", "runserver", "0.0.0.0:8000"]
