
module Mutations
  class Login < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: false

    def resolve(email:, password:)
      user = User.find_by(email: email)

      if user&.authenticate(password)
        token = JWT.encode({ user_id: user.id, exp: 1.hour.from_now.to_i }, 'secret', 'HS256')
        { token: token }
      else
        raise GraphQL::ExecutionError, 'Invalid email or password'
      end
    end
  end
end




# mutation {
#   login(input: {
#     email: "test@email.com"
#     password: "password"
#   }) {
#     token
#   }
# } 