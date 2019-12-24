FROM ruby:2.6.3 as builder

RUN apt update
RUN apt install -y \
    locales \
    graphviz \
    imagemagick \
    postgresql-client-11

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    /usr/sbin/locale-gen
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

ARG RAILS_ENV
ENV RAILS_ENV=$RAILS_ENV


ENV APP_ROOT=/app
WORKDIR $APP_ROOT/
COPY Gemfile.lock $APP_ROOT/
COPY Gemfile $APP_ROOT/

RUN gem install bundler
RUN gem install rake
RUN bundle install

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

