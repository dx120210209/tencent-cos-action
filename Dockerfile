FROM ruby:3.3.5-alpine
WORKDIR /app
COPY app.rb app.rb
RUN gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ \
    && gem install httparty
COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
