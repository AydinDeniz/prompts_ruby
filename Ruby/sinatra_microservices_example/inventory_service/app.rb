
require 'sinatra'
require 'redis'
require 'json'
require 'logger'
require 'net/http'

# Initialize Redis and Logger
redis = Redis.new
logger = Logger.new(STDOUT)

# Inventory management endpoints
post '/items' do
  begin
    data = JSON.parse(request.body.read)
    item_id = data['id']
    redis.set("item:#{item_id}", data.to_json)
    logger.info("Item added to inventory: #{data}")
    status 201
    data.to_json
  rescue => e
    logger.error("Error adding item to inventory: #{e.message}")
    status 500
    { error: 'Failed to add item to inventory' }.to_json
  end
end

get '/items/:id' do
  begin
    item = redis.get("item:#{params['id']}")
    if item
      logger.info("Item retrieved: #{item}")
      status 200
      item
    else
      status 404
      { error: 'Item not found' }.to_json
    end
  rescue => e
    logger.error("Error retrieving item: #{e.message}")
    status 500
    { error: 'Failed to retrieve item' }.to_json
  end
end
