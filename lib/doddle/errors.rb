module Doddle

  class Error < StandardError; end

  #generic response error
  class ResponseError < Error

    #extends forwardable so a response can be passed
    extend Forwardable

    def_delegators :@response, :body, :body_json, :code

    attr_reader :message, :messages
    def initialize(response)
      @response = response
      @message = "The response produced an error. HTTP Code: #{response.code}"
      @messages = []
      process
    end

    private
    def process

      if body_json != nil && body_json.has_key?("errors")
        body_json["errors"].each do |i|
          @messages << i
        end
      end

    end

  end

end
