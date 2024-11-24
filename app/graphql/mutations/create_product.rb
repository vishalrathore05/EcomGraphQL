module Mutations
    class CreateProduct < BaseMutation
       argument :name, String, required: true
      argument :price, Float, required: true
      argument :category, String, required: true
      
      field :product, Types::ProductType, null: true
      field :errors, [String], null: false
  
      def resolve(name:, price:, category:)
        category = Category.find_or_create_by(name: category)   
        product = Product.new(name: name, price: price, category: category)
        if product.save
        { product: product, errors: [] }
        else
          { product: nil, errors: product.errors.full_messages }
        end
      rescue StandardError => e  #display error in perfect view
        raise GraphQL::ExecutionError.new(
          "An error occurred while creating the user",
          extensions: {
            code: "USER_CREATION_FAILED",
            details: { name: name, price: price, category: category }
          }
        )
      end
    end
  end
  
 

#   mutation {
#   createProduct(input: {
#     name: "New Product",
#     price: 100.0,
#     category:  "system" 
#   }) {
#     product {
#       id
#       name
#       price
#       category {
#         id
#         name
#       }
#     }
#     errors
#   }
# }

# User = Done
# Category = Done
# Producy = Done 
# Order = Done 

# Would you like to dive into pagination, performance optimizations, or another topic next? Let me know! 😊