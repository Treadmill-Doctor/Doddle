module Doddle
  class Client

    attr_reader :default_header
    attr_reader :token_header
    attr_reader :token
    attr_reader :company_id
    attr_reader :domain
    attr_reader :company_id

    def initialize(opts = {})
      @company_id = opts[:company_id]
      @domain = "https://apigw.apac-preprod.doddle.tech"

      @default_header = {
        'Content-Type' => 'application/json',
      }
      @token_header = @default_header.clone

      @default_header["Authorization"] = "Basic #{Base64.encode64("#{opts[:api_key]}:#{opts[:api_secret]}").gsub("\n", '').chomp}"
    end

    def set_token(t)
      @token = t
      @token_header["Authorization"] = "Bearer #{t}"
    end

    def get_token

      #this is only used if something just goes wrong, will fully implement later
      uri = URI.parse(@domain + "/v1/oauth/token")

      # Create the HTTP objects
      http = Net::HTTP.new(uri.host, uri.port)

      http.use_ssl = true

      params = {
        grant_type: "client_credentials",
        scope: "orders:write"
      }

      request = Net::HTTP::Post.new(uri.request_uri, default_header)

      request.body = params.to_json
      # Send the request
      response = http.request(request)
      
      return Doddle::TokenResponse.new( body: response.body, code: response.code )

    end

  end
end
