FROM ruby:3.3.5-alpine
WORKDIR /github/workspace
COPY app.rb /app.rb
RUN gem install httparty

CMD ["ruby", "/app.rb"]
