FROM python:3.9-alpine3.13

ENV PYTHONUNBUFFERED 1
ENV DEV=true

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app

WORKDIR /app

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    /py/bin/pip install django && \
    if [ "$DEV" = "true" ]; then /py/bin/pip install -r /tmp/requirements.dev.txt; fi && \
    rm -rf /tmp && \
    adduser --disabled-password --no-create-home django-user

ENV PATH="/py/bin:$PATH"

USER django-user