FROM cgr.dev/chainguard/python:latest-dev as build
USER root
ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN python -m venv /note-app/venv
ENV PATH="/note-app/venv/bin:$PATH"

WORKDIR /note-app

#COPY libjpeg-3.0.4-r0.apk .
#RUN apk add --allow-untrusted ./libjpeg-3.0.4-r0.apk
RUN apk add zlib-dev libjpeg-turbo-dev
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM cgr.dev/chainguard/python:latest

WORKDIR /note-app

ENV PYTHONBUFFERED 1

COPY --from=build /note-app/venv /note-app/venv
ENV PATH "/note-app/venv/bin:$PATH"

COPY ./blog .
COPY ./django_project .
COPY ./media .
COPY ./users .
COPY ./static .
COPY manage.py .

ENTRYPOINT ["python", "/note-app/manage.py", "runserver"]

