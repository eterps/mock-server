FROM iron/ruby
WORKDIR /app
ADD . /app
ENTRYPOINT ["ruby", "mock_server.rb"]
EXPOSE 8080
