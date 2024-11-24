module Types
    class ProductType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :description, String, null: true
      field :price, Float, null: false
      field :category, CategoryType, null: true
    end
  end