# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

#resolvers
    field :product, resolver: Resolvers::ProductResolver
    field :products_by_price, resolver: Resolvers::ProductPriceResolver
    field :paginated_categories, resolver: Resolvers::PaginatedCategoryResolver
    field :paginated_orders, resolver: Resolvers::PaginatedOrderResolver
    field :paginated_products, resolver: Resolvers::PaginatedProductResolver
    field :user, resolver: Resolvers::UserResolver
    field :category, resolver: Resolvers::CategoryResolver
    field :order, resolver: Resolvers::OrderResolver
# ------------------------

    field :all_products, [ProductType], null: false do
      description "Fetch all products"
    end

    field :all_categories, [CategoryType], null: false do
      description "Fetch all categories"  
    end

    field :all_orders, [OrderType], null: false do 
      description "Fetch all orders"
    end 

    def all_products
      Product.includes(:category)
    end

    def all_categories  
      Category.includes(:product)
    end
    
    def all_orders
      Order.includes(:product)
    end

    
    # field :product, Types::ProductType, null: true do 
    #   argument :id, ID, required: true
    #  end 

    #  field :product, Types::ProductType, null: true do 
    #   argument :price, Float, required: true
    #  end      

 
    # query {
    #     product(price: 100,) {
    #       id
    #       name
    #       price
    #       category {
    #         id
    #         name
    #       }
    #     }
    #   }
    
          
  end
end
