module Mutations
    class Logout < BaseMutation
      argument :token, String, required: true
  
      field :message, String, null: false
  
      def resolve(token:)
        # Decode the token to validate and extract the user information
        decoded_token = JWT.decode(token, 'secret', true, { algorithm: 'HS256' }) rescue nil
        raise GraphQL::ExecutionError, "Invalid or expired token" unless decoded_token
  
        # Check if the token has already been revoked
        if RevokedToken.exists?(token: token)
          raise GraphQL::ExecutionError, "Token has already been revoked"
        end
  
        # Revoke the token by storing it in the database
        RevokedToken.create!(token: token, user_id: decoded_token[0]['user_id'])
  
        { message: "Successfully logged out" }
      end
    end
  end
  