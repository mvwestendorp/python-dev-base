FROM python:3.7-slim

ENV PYTHONUNBUFFERED 1
WORKDIR /app
COPY requirements.txt /app
# Install requirements
# RUN sudo apt install libcurl4-openssl-dev libssl-dev python3-bs4
# RUN apk add --update --no-cache libc-dev gcc g++ libxslt-dev
RUN pip install --no-cache-dir -r requirements.txt
