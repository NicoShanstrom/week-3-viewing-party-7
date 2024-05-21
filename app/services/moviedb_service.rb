class MoviedbService

  def initialize
    @connect = Faraday.new(url: "https://api.themoviedb.org") do |conn|
      conn.request :authorization, 'Bearer', Rails.application.credentials.themoviedb[:bearer_token]
    end
  end
  
  def get(path, params = {})
    response = @connect.get(path, params)
    handle_response(response)
  rescue Faraday::Error => e
    raise "Faraday Error: #{e.message}"
  end

  private
  
  def handle_response(response)
    return {} unless response&.success?
    
    content_type = response.headers["Content-Type"]
    if content_type.include?("application/json")
      JSON.parse(response.body, symbolize_names: true)
    else
      raise "Unexpected content type: #{content_type}"
    end
  end
end