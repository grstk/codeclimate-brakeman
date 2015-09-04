FROM ruby:2.2.3-slim
MAINTAINER Code Climate

COPY . /usr/src/app
WORKDIR /usr/src/app/
RUN bundle install --jobs 4 --without "development test"

RUN adduser --uid 9000 app
USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/bin/brakeman"]
