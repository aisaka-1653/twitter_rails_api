# frozen_string_literal: true

class CreateUserFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :user_follows do |t|
      t.references :from_user, null: false, foreign_key: { to_table: :users }
      t.references :to_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :user_follows, %i[from_user_id to_user_id], unique: true
  end
end
