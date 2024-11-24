module Mutations
    class UpdateUser < BaseMutation
        argument :id, ID, required: true
        argument :first_name, String, required: false
        argument :last_name, String, required: false
        argument :email, String , required: false
    
        field :user, Types::UserType, null: false
        field :errors, [String], null: true
    
        def resolve(id:, first_name:, last_name:, email:)
            user = User.find(id)
            if user.update(first_name: first_name, last_name: last_name, email: email)
                { user: user}
            else
                { user: nil, errors: user.errors.full_messages }
            end
        end
    end
end 