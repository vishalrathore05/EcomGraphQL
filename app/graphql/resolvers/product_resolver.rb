module Resolvers
    class ProductResolver < GraphQL::Schema::Resolver
      type Types::ProductType, null: true
      argument :name, String, required: true
  
      def resolve(name:)        
        product = Product.find_by(name: name)
        return product if product   
        # Handle errors gracefully
        raise GraphQL::ExecutionError.new(
          "Product not found",
          extensions: { code: "PRODUCT_NOT_FOUND", details: { name: name } }
        )
      end
    end
  end

#   query {
#     product(name: "Horror") {
#         id
#         name
#         price
#         category {
#         id
#         name
#         }
#      }
#    }