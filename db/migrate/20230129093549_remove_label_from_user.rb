class RemoveLabelFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :labels, :users
    remove_index :labels,:user_id
    remove_column :labels, :user_id, :bigint
  end
end
