module Doddle
  module Apis

    class Order


      def initialize(client)
        @client = client
      end

      def create(order)

        #this is only used if something just goes wrong, will fully implement later
        uri = URI.parse(@client.domain + "/v2/orders/")

        # Create the HTTP objects
        http = Net::HTTP.new(uri.host, uri.port)

        #http.set_debug_output($stdout)

        http.use_ssl = true

        request = Net::HTTP::Post.new(uri.request_uri, @client.token_header)

        request.body = build_json(order)
        # Send the request
        response = http.request(request)

        return Doddle::OrderResponse.new(body: response.body, code: response.code)

      end


      private
      def build_json(order)

        data = {
          companyId: @client.company_id,
          referenceId: order.id, #record id
          externalOrderId: order.order_number,
          orderType: "EXTERNAL",

          customer: {
            email: order.email,
            name: {
              firstName: order.first_name,
              lastName: order.last_name
            },

            mobileNumber: order.phone_number
          },

          externalOrderData: {
            purchaseDate: order.created_at.strftime("%d-%m-%Y"),


          }
        }

        address = {
          country: order.address[:country],
          line1: order.address[:line_1],
          postcode: order.address[:postal_code],
          town: order.address[:city],
          area: order.address[:state]
        }

        if order.address[:line_2] != nil
          address[:line2] = order.address[:line_2]
        end

        if order.address[:line_3] != nil
          address[:line3] = order.address[:line_3]
        end

        data[:externalOrderData][:deliveryAddress] = address


        data[:orderLines] = []
        order.items.each do |i|
          data[:orderLines] << {

            sourceLocation: [
                {
                    locationType: "external"
                }
            ],

            destinationLocation: {
              locationType: "external"
            },

            fulfilmentMethod: "NONE",

            priceCurrency: order.currency,
            product: {
              description: i[:name],
              imageUrl: i[:image_url],
              isNotReturnable: !i[:can_return],
              #"price": i[:price],
              productId: i[:product_id],
              quantity: i[:quantity],
              sku: i[:sku]
            }

          }

          return data.to_json
        end
      end

    #END CLASS
    end
  end
end
