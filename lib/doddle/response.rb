module Doddle
  #decorates a result set with response details
  class Response

    include Doddle::Utilities

    attr_reader :body
    attr_reader :body_json
    attr_reader :code

    HTTP_ERR_CODES = %w(500 404 400 401 403)

    def initialize(opts = {})
      @body = opts[:body]
      @code = opts[:code]

      process

    end

    private
    def process

      json_is_valid = valid_json?(body)
      if json_is_valid
        @body_json = JSON.parse(body)
      end

      success = !HTTP_ERR_CODES.include?(code)

      if !(success && json_is_valid)
        raise ResponseError.new(self)
      end

    end

  end


end
