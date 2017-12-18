FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /financial-stock-check
WORKDIR /financial-stock-check
COPY Gemfile /financial-stock-check/Gemfile
COPY Gemfile.lock /financial-stock-check/Gemfile.lock
RUN bundle install
COPY . /financial-stock-check