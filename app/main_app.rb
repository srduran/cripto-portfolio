class Endpoints
  def initialize
    @currency_converter = CurrencyConverter.new
  end

  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    method = request.request_method
    path = request.path
    body = request.body&.read || ''
    response['Content-Type'] = 'application/json'
    
    case [path, method]
    when ['/convert', 'POST']
      begin
        data = JSON.parse(body)
        unless data['portfolio'] && data['fiat_currency']
          response.status = 400
          response.write({ error: 'Missing required fields: portfolio and fiat_currency' }.to_json)
          return response.finish
        end
        response.status = 200
        response.write(@currency_converter.convert(data).to_json)
      end
    when ['/openapi', 'GET']
      response.status = 200
      response['Content-Type'] = 'text/yaml'
      response.write(File.read('static/openapi.yaml'))
    else
      response.status = 404
      response.write({ error: 'Not Found' }.to_json)
    end
    response.finish
  end
end