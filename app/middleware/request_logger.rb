class RequestLogger
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    log_request(request)
    @app.call(env)
  end

  private

  def log_request(request)
    log_entry = {
      timestamp: Time.now,
      method: request.request_method,
      path: request.fullpath,
      params: request.params,
      ip: request.ip
    }
    MONGODB_COLLECTION.insert_one(log_entry)
  end
end
