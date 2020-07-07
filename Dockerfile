FROM python:3.8-slim

ENV PYTHONUNBUFFERED 1
WORKDIR /app
COPY requirements.txt /app
# Install requirements
# RUN sudo apt install libcurl4-openssl-dev libssl-dev python3-bs4
# RUN apk add --update --no-cache libc-dev gcc g++ libxslt-dev
RUN mkdir -p /usr/share/man/man1 && \
    apt-get -y update && \
    apt-get install --no-install-recommends -y openjdk-11-jre-headless ca-certificates-java wget && \
    rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir -r requirements.txt
ENV SPARK_VERSION=3.0.0
ENV HADOOP_VERSION=3.2
RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
          && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
          && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark \
          && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
ENV SPARK_HOME=/app/spark
ENV PATH=$PATH:$SPARK_HOME/bin
ENV PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.9-src.zip:$PYTHONPATH

RUN wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.4/hadoop-aws-2.7.4.jar \
 -P /$SPARK_HOME/jars/ && \
 wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-core/1.11.817/aws-java-sdk-core-1.11.817.jar \
 -P /$SPARK_HOME/jars/ && \
  wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.11.817/aws-java-sdk-s3-1.11.817.jar \
  -P /$SPARK_HOME/jars/
