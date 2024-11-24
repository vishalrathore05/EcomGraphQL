module Resolvers
  class PaginatedCategoryResolver < GraphQL::Schema::Resolver 
    type [Types::CategoryType], null: true
    argument :limit, Integer, required: false, default_value: 1

    def resolve(limit:)
      categories = Category.limit(limit)
      if categories.any?
          categories 
      else 
          rails GraphQL::ExecutionError.new(
            "No categories found",
            extensions: { code: "N0_category_found", details: { limit: limit } }
          )
      end
    end 
  end 
end