FROM alpine:edge
MAINTAINER Code Climate

COPY . /usr/src/app
WORKDIR /usr/src/app/
RUN apk --update add ruby ruby-io-console ruby-dev ruby-bundler ruby-json build-base && \
    bundle install -j 4 && \
    apk del build-base && rm -fr /usr/share/ri

RUN adduser -u 9000 -D app
USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/bin/brakeman"]
