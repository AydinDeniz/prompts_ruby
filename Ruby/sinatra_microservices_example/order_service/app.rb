
require 'sinatra'
require 'redis'
require 'json'
require 'logger'
require 'net/http'

# Initialize Redis and Logger
redis = Redis.new
logger = Logger.new(STDOUT)

# Order processing endpoints
post '/orders' do
  begin
    data = JSON.parse(request.body.read)
    order_id = data['id']
    redis.set("order:#{order_id}", data.to_json)
    logger.info("Order created: #{data}")
    status 201
    data.to_json
  rescue => e
    logger.error("Error creating order: #{e.message}")
    status 500
    { error: 'Failed to create order' }.to_json
  end
end

get '/orders/:id' do
  begin
    order = redis.get("order:#{params['id']}")
    if order
      logger.info("Order retrieved: #{order}")
      status 200
      order
    else
      status 404
      { error: 'Order not found' }.to_json
    end
  rescue => e
    logger.error("Error retrieving order: #{e.message}")
    status 500
    { error: 'Failed to retrieve order' }.to_json
  end
end
