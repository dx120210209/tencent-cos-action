FROM ruby:3.3.5-alpine
WORKDIR /app
COPY app.rb app.rb
RUN gem install httparty
COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
