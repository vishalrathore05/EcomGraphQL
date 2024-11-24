module Mutations
    class CreateCategory < BaseMutation
        argument :name, String, required: true

        field :category, Types::CategoryType, null: true 
        field :errors, [String], null: false

        def resolve(name:)
            category = Category.new(name: name)
            if category.save
                { category: category, errors: [] }
            else
                { product: nil, errors: product.errors.full_messages }
            end
        end
    end
end


        
        


# mutation {
#   createCategory( input: {name: "new category s here "}){
#     category {
#        id
#        name
#     }
#   }
# }