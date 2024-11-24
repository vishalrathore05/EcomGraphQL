module Resolvers
  class UserResolver < GraphQL::Schema::Resolver
    type Types::UserType, null: true
    argument :first_name, String, required: true
    
    def resolve(first_name:)
      user = User.find_by(first_name: first_name)
      return user if user

      raise GraphQL::ExecutionError.new(
        "User not found",
        extensions: { code: "User_not_found", details: { first_name: first_name } }
      )
    end
  end
end 

# query {
#     user(firstName: "v") {
#       id
#       firstName
#     }
#   }


# Batching Queries (Basic Overview)

# query {
#     product(name: "Horror") {
#         id
#         name
#         price
#         category {
#         id
#         name
#         } 
#      }
#     user(firstName: "Alice"){
#       id
#       firstName
#     }
#    }