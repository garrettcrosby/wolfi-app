#BUILD STAGE
FROM cgr.dev/chainguard/python:latest-dev as build
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
FROM cgr.dev/chainguard/python:latest

WORKDIR /note-app

ENV PYTHONBUFFERED 1

COPY --from=build /note-app/venv /note-app/venv
COPY --from=build /usr/lib/libjpeg.so.8 /usr/lib/libjpeg.so.8

ENV PATH "/note-app/venv/bin:$PATH"

COPY . .

ENTRYPOINT ["python", "/note-app/manage.py", "runserver", "0.0.0.0:8000"]
