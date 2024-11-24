
module Mutations
    class CreateOrder < BaseMutation
        argument :user_id, ID, required: true
        argument :quantity, Integer, required: true
        argument :product_name, String, required: true
        argument :category_name, String, required: true

        field :order, Types::OrderType, null: true
        field :errors, [String], null: false
        
        def resolve(user_id:, quantity:, product_name:, category_name:)
            user = User.find_by(id: user_id)
            return { order: nil, errors: ["User not found"] } unless user

            category = Category.find_or_create_by(name: category_name)
            return { order: nil, errors: ["Category not found"] } unless category.persisted?
   
            product = Product.find_or_create_by(name: product_name, category: category )
            return { order: nil, errors: ["Product not found"]} unless product.persisted?

            order  = Order.new(quantity: quantity, user: user, product: product)
            if order.save
                { order: order, errors: [] }
            else
                { order: nil, errors: order.errors.full_messages }
            end
        end
    end
end



# mutation {
#   createOrder(
#     input: {
#       userId: 1,
#       quantity: 12,
#       productName: "Alice",
#       categoryName: "Electronics"
#     }
#   ) {
#     order {
#       id
#       quantity
#       user {
#         id
#         firstName
#       }
#       product {
#         id
#         name
#         price
#         category {
#           id
#           name
#         }
#       }
#     }
#     errors
#   }
# }
