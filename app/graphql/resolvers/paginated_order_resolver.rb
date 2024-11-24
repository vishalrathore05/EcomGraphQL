module Resolvers
    class PaginatedOrderResolver < GraphQL::Schema::Resolver
        type [Types::OrderType], null: true
        argument :limit, Integer, required: false, default_value: 1

        def resolve(limit:)
            orders = Order.limit(limit)

            if orders.any?
                orders 
            else
                raise GraphQL::ExecutionError.new(
                  "No products found",
                  extensions: { code: "NO_PRODUCTS_FOUND", details: { limit: limit } }
                )
              end
        end
    end
end


# query {
#   paginatedOrders(limit: 10) {
#       id
#       quantity 
#     	product {
#         id
#         name
#       }
#   }
# }
