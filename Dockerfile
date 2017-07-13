FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

ENV RAILS_ENV development

ADD Gemfile /app/  
ADD Gemfile.lock /app/

RUN gem install bundler && \
    cd /app ; bundle config build.nokogiri --use-system-libraries && bundle install

ADD . /app  
RUN chown -R nobody:nogroup /app  

USER nobody
WORKDIR /app

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
