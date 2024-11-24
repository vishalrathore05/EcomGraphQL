module Resolvers
    class CategoryResolver < GraphQL::Schema::Resolver
        type Types::CategoryType, null: true
        argument :name, String, required: true

        def resolve(name:)
            category = Category.find_by(name: name)
            return category if category

            #handle errors
            raise GraphQL::ExecutionError.new(
                "Category not found",
                extensions: { code: "category_not_found", details: { category: category } }
              )
        end
    end
end



#query

# query {
#     category(name: "Electronics") {
#       id
#        name
#     }
#   }
  