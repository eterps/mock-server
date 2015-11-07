require_relative 'bundle/bundler/setup'
require 'sinatra/base'

class MockServer < Sinatra::Base
  set :port, ENV['PORT'] || 8080
  set :bind, '0.0.0.0'

  MOCKS = {}

  post '/_mocks' do
    payload = JSON(request.body.read)

    MOCKS[payload['request']] = payload['response']
  end

  get '/*' do |path|
    mock = MOCKS[{'path' => path}]

    status mock['status']
    headers mock['headers']
    body mock['body']
  end

  run! if app_file == $PROGRAM_NAME
end
