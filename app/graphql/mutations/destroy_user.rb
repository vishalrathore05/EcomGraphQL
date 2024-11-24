module Mutations
    class DestroyUser < BaseMutation
      argument :id, ID, required: true
  
      field :user, Types::UserType, null: true
      field :errors, [String], null: true
  
      def resolve(id:)
        user = User.find_by(id: id)
        
        if user && user.destroy
          { user: user, errors: [] }
        else
          { user: nil, errors: ['User not found or could not be deleted'] }
        end
      end
    end
  end
  