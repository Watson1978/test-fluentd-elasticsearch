FROM fluent/fluentd:v1.18-debian-1

USER root

RUN apt update && apt install -y procps git gcc make
RUN rm -rf fluentd && git clone https://github.com/fluent/fluentd.git --depth 1 && \
    cd fluentd && \
    sed -i "s/VERSION = '1\.18\.0'/VERSION = '1.19.0'/" lib/fluent/version.rb && \
    rake build && \
    gem install pkg/fluentd-1.19.0.gem
RUN gem install faraday --no-document --version 1.10.4
RUN gem install elasticsearch --no-document --version 7.17.11
RUN gem install fluent-plugin-elasticsearch --no-document --version 5.2.5
RUN gem install leak_profiler --no-document --version 0.4.0

#USER fluent
