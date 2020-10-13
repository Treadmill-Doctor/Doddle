module Doddle
  class Order

    #Order Metadata
    attr_accessor :id, :doddle_id, :created_at, :order_number, :currency


    #Items
    attr_accessor :items

    #Addresses
    attr_accessor :address

    #Customer
    attr_accessor :email, :first_name, :last_name, :phone_number


    def initialize(opts = {})
      @items = []
    end


  end
end
