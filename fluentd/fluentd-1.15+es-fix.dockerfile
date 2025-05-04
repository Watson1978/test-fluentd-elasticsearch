FROM fluent/fluentd:v1.15-debian-1

USER root

RUN apt update && apt install -y procps git
RUN gem install faraday --no-document --version 1.10.4
RUN gem install elasticsearch --no-document --version 7.17.11
# RUN gem install fluent-plugin-elasticsearch --no-document --version 5.2.5
RUN gem install leak_profiler --no-document --version 0.4.0

RUN git clone https://github.com/Watson1978/fluent-plugin-elasticsearch.git && \
    cd fluent-plugin-elasticsearch && \
    git checkout a800e37 && \
    gem build fluent-plugin-elasticsearch.gemspec && \
    gem install fluent-plugin-elasticsearch-*.gem

#USER fluent
