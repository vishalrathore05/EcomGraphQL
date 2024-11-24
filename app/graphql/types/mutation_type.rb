module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :update_user, mutation: Mutations::UpdateUser
    field :destroy_user, mutation: Mutations::DestroyUser
    field :create_product, mutation: Mutations::CreateProduct
    field :create_order, mutation: Mutations::CreateOrder
    field :create_category, mutation: Mutations::CreateCategory
    field :login, mutation: Mutations::Login
    field :logout, mutation: Mutations::Logout

  end 

end 