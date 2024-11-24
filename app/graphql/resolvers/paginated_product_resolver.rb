module Resolvers
  class PaginatedProductResolver < GraphQL::Schema::Resolver
    type [Types::ProductType], null: true
    argument :limit, Integer, required: false, default_value: 1

    def resolve(limit:)
      products = Product.limit(limit)

      if products.any?
        products
      else
        raise GraphQL::ExecutionError.new(
          "No products found",
          extensions: { code: "NO_PRODUCTS_FOUND", details: { limit: limit } }
        )
      end
    end
  end
end
