require 'rack/test'
require_relative '../../mock_server'

module AppHelper
  def app
    MockServer
  end
end

World Rack::Test::Methods, AppHelper
