module Doddle
  class TokenResponse < Response
    attr_reader :token
    def initialize(opts = {})
      super

      init_values

    end

    private
    def init_values

      #set token
      @token = body_json["access_token"]

    end
  end
end
