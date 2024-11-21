FROM ruby:3.3.5
WORKDIR /app
COPY app.rb app.rb
RUN gem install httparty

CMD ["ruby", "/app/app.rb"]
