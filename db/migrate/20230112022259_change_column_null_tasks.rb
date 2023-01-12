class ChangeColumnNullTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :task_name, :string, null: false
    change_column :tasks, :task_content, :text, null: false
    change_column :tasks, :deadline, :date, null: false
    change_column :tasks, :status, :string, null: false
    change_column :tasks, :priority, :string, null: false
  end
end
