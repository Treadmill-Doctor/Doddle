require "test_helper"

class DoddleTest < Minitest::Test
  include Doddle::Test::Credentials

  def setup
    @client = Doddle::Client.new( creds.merge(company_id: "TREADMILL_DOCTOR", env: "development") )
    response = @client.get_token
    @client.set_token(response.token)
  end

  def test_doddle_create_order

    #ORDER DATA
    order = Doddle::Order.new
    order.id = "12345"
    order.created_at = Time.now
    order.order_number = "12345"
    order.currency = "USD"

    order.items << {
      product_id: "8888",
      name: "Walking Belt",
      image_url: "https://cdn.treadmilldoctor.com/uploads/asset/file/5208/ak63002630004-lf-left-pedal.jpg",
      can_return: true,
      quantity: 1,
      sku: "wb-3629"
    }

    order.address = {country: "US", line_1: "1603 Johnston Rd.", postal_code: "38632", city: "Hernando", state: "Mississippi"}

    order.first_name = "Cannon"
    order.last_name = "Moyer"
    order.email = "cannon.moyer@treadmilldoctor.com"
    order.phone_number = "901-362-3360"


    #CALL ORDER API ENDPOINT

    order_api = Doddle::Apis::Order.new(@client)
    o = order_api.create(order)

    assert_equal Doddle::OrderResponse, o.class
  end


  def test_gets_order_by_id
    order_api = Doddle::Apis::Order.new(@client)
    order_api.get_by_id("a4e7123b-f914-4111-b7b9-895068c9ce04")
  end

end
