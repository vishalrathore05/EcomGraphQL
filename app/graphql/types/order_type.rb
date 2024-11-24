module Types
    class OrderType < Types::BaseObject
      field :id, ID, null: false
      field :quantity, Integer, null: false
      field :user, UserType, null: false
      field :product, ProductType, null: false
    end
  end
  