 module Mutations
    class CreateUser < BaseMutation
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :email, String, required: true
  
      field :user, Types::UserType, null: false
      field :errors, [String], null: true
  
      def resolve(first_name:, last_name:, email:)
        user = User.new(first_name: first_name, last_name: last_name, email: email)
        if user.save
          { user: user, errors: [] }
        else
          { user: nil, errors: user.errors.full_messages }
        end
      end
    end
  end
  