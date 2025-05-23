FROM fluent/fluentd:v1.16-debian-1

USER root

RUN apt update && apt install -y procps
RUN gem install faraday --no-document --version 1.10.4
RUN gem install elasticsearch --no-document --version 7.17.11
RUN gem install fluent-plugin-elasticsearch --no-document --version 5.2.5
RUN gem install leak_profiler --no-document --version 0.4.0

#USER fluent
