FROM ubuntu:22.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install gpg wget apt-transport-https -y && \
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | gpg --dearmor -o /usr/share/keyrings/elastic-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/elastic-keyring.gpg] https://artifacts.elastic.co/packages/oss-8.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-8.x.list && \
    apt-get update && \ 
    apt-get install logstash-oss=1:8.9.2-1 && \ 
    chown -R logstash /usr/share/logstash 

COPY logstash.conf /usr/share/logstash/pipeline/logstash.conf
COPY pipelines.yml /usr/share/logstash/config/pipelines.yml
COPY jvm.options /usr/share/logstash/config/jvm.options

USER logstash

ENTRYPOINT ["/usr/share/logstash/bin/logstash"]
