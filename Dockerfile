FROM ruby:2.3.3-alpine
MAINTAINER Code Climate

COPY . /usr/src/app
WORKDIR /usr/src/app/
RUN bundle install --jobs 4 --without "development test"

RUN adduser -u 9000 -D app
USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/bin/brakeman"]
