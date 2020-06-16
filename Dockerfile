FROM fluent/fluentd:v1.11-1

# Use root account to use apk
USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN apk add --no-cache --update --virtual .build-deps \
    sudo build-base ruby-dev \
    && sudo gem install fluent-plugin-kubernetes_metadata_filter \
    && sudo gem install fluent-plugin-gelf-hs \
    && sudo gem install fluent-plugin-record-modifier \
    && sudo gem install fluent-plugin-rewrite-tag-filter \
    && sudo gem install fluent-plugin-multi-format-parser \
    && sudo gem install fluent-plugin-json-transform \
    && sudo gem install fluent-plugin-flatten-hash \
    && sudo gem install fluent-plugin-script \
    && sudo gem sources --clear-all \
    && apk del .build-deps \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

ENV GRAYLOG_PORT=12201
ENV GRAYLOG_PROTOCOL=tcp

LABEL version="v1.11-1"
LABEL name="fluentd-kubernetes-gelf"
