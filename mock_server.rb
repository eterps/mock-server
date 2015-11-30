require_relative 'bundle/bundler/setup'
require 'sinatra/base'
require 'json'

class MockServer < Sinatra::Base
  set :port, ENV['PORT'] || 8080
  set :bind, '0.0.0.0'

  LAST_REQUEST = nil
  MOCKS = {}

  post '/_mocks' do
    payload = JSON(request.body.read)

    MOCKS[payload['request']] = payload['response']

    ''
  end

  get '/_last_request' do
    JSON.pretty_unparse(Hash[*LAST_REQUEST.env.select{|k, v| k.upcase == k}.sort.flatten])
  end

  get '/*' do |path|
    LAST_REQUEST = request

    mock = MOCKS[{'path' => path}]

    status mock['status']
    headers mock['headers']
    body mock['body']
  end

  options '/*' do |path|
    LAST_REQUEST = request

    mock = MOCKS[{'path' => path}]

    status mock['status']
    headers mock['headers']
  end

  post '/*' do |path|
    LAST_REQUEST = request

    mock = MOCKS[{'path' => path, 'method' => 'POST'}]
    mock ||= MOCKS[{'path' => path}]

    status mock['status']
    headers mock['headers']
    body mock['body']
  end

  run! if app_file == $PROGRAM_NAME
end
