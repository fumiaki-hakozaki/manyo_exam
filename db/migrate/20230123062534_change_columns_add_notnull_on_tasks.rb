class ChangeColumnsAddNotnullOnTasks < ActiveRecord::Migration[6.0]
  def up
    change_column :tasks, :user_id, :bigint, null: false
  end
end
