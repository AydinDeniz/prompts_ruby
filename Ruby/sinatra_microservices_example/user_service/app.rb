
require 'sinatra'
require 'redis'
require 'json'
require 'logger'

# Initialize Redis and Logger
redis = Redis.new
logger = Logger.new(STDOUT)

# User management endpoints
post '/users' do
  begin
    data = JSON.parse(request.body.read)
    user_id = data['id']
    redis.set("user:#{user_id}", data.to_json)
    logger.info("User created: #{data}")
    status 201
    data.to_json
  rescue => e
    logger.error("Error creating user: #{e.message}")
    status 500
    { error: 'Failed to create user' }.to_json
  end
end

get '/users/:id' do
  begin
    user = redis.get("user:#{params['id']}")
    if user
      logger.info("User retrieved: #{user}")
      status 200
      user
    else
      status 404
      { error: 'User not found' }.to_json
    end
  rescue => e
    logger.error("Error retrieving user: #{e.message}")
    status 500
    { error: 'Failed to retrieve user' }.to_json
  end
end
