FROM ruby:2.7.4

RUN apt-get update -qq && apt-get install -y nodejs

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY . /app/

ENTRYPOINT ["bin/rails"]
CMD ["s", "-b", "0.0.0.0"]
EXPOSE 3000
