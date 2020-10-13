module Doddle
  class OrderResponse < Response
    attr_reader :order
    def initialize(opts = {})
      super

      init_values
    end

    private
    def init_values
      @order = Order.new
      @order.doddle_id = body_json["resource"]["orderId"]

    end
  end
end
