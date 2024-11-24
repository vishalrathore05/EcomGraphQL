class CreateRevokedTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :revoked_tokens do |t|
      t.string :token
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :revoked_tokens, :token
  end
end
