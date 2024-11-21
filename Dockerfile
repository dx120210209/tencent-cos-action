FROM ruby:3.3.5-alpine
COPY app.rb app.rb
RUN gem install httparty

ENTRYPOINT ["ruby", "app.rb"]
