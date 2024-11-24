module Resolvers
    class OrderResolver < GraphQL::Schema::Resolver
        type Types::OrderType, null: true
        argument :quantity, Integer, required: true

        def resolve(quantity:)
            order = Order.find_by(quantity: quantity)
            return order if order

            raise GraphQL::ExecutionError.new(
                "order not found",
                extensions: { code: "order_not_found", details: { quantity: quantity } }
            )
        end
    end
end


  
# query {
#     order(quantity: 1) {
#       id
#        name
#     }
#   }