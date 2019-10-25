# application.rb
require 'sinatra'
require 'net/http'
require 'json'
require 'redis-sinatra'

#require 'byebug'

register Sinatra::Cache

configure do
  set :show_exceptions, true

  # Un-comment this if you are using Vagrant or any type of VM/container such as Docker
  set :bind, '0.0.0.0'
end

helpers do
  def get_credentials
    settings.cache.fetch("token_#{@auth_header}", expires_in: 86_400) do
      req = Net::HTTP.get_response(URI("http://events.chargify.test:3000/#{params['subdomain']}/verify_token/#{@auth_header}"))
      if req.code == '200'
        JSON.parse(req.body)['credentials']
      else
        nil
      end
    end
  end
end

before do
  if request.request_method != 'GET'
    # Pull out the authorization header
    if env['HTTP_AUTHORIZATION']
      @auth_header = env['HTTP_AUTHORIZATION']
    else
      halt 401
    end
  end
end

################################
# Application Routes
################################

# curl -H "Content-Type: application/json" -H "Authorization: Basic SThMamNwVjZOcWI4Y0MxM05oQ2N1Tlh6eUdBYW5VbHk1SWJnSzNUblVrMA==\n" -d '{"key1":"value1", "key2":"value2"}'  http://events.chargify.test:3000/acme-inc-21/events/dupa

# Service1: Return all our Text entities
post "/:subdomain/events" do
  pass unless request.accept? 'application/json'
  content_type :json

  if credentials = get_credentials
    req = Net::HTTP.post(URI('http://localhost:4567/api/events'),
                         request.body.read,
                         { "Content-Type" => "application/json",
                           "Authorization" => credentials })
    req.code
  else
    pass
  end
end

################################
# 404
################################
not_found do
  'Whatever you are looking for its not here!'
end

################################
# 500
################################
error do
  'Sorry there was a nasty error - ' + env['sinatra.error'].name
end

