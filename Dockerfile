FROM python:3.7-alpine

WORKDIR /app
COPY requirements.txt /app
# Install requirements
# RUN sudo apt install libcurl4-openssl-dev libssl-dev python3-bs4
RUN apk add --update --no-cache libc-dev gcc g++ libxslt-dev
RUN pip install -r requirements.txt