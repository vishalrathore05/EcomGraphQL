module Resolvers
  class ProductPriceResolver < GraphQL::Schema::Resolver
    type [Types::ProductType], null: true
    argument :min_price, Float, required: true
    argument :max_price, Float, required: true
    
    def resolve(min_price:, max_price:)
      products = Product.where(price: min_price..max_price)

      if products.any?
        return products
      else
      raise GraphQL::ExecutionError.new(
        "No products found within the price range",
        extensions: { code: "PRODUCT_NOT_FOUND", details: { min_price: min_price, max_price: max_price } }
      )
      end
    end
  end
end