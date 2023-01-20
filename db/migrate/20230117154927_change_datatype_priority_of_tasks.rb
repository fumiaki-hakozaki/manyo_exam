class ChangeDatatypePriorityOfTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :priority,  'integer USING CAST(priority AS integer)'
  end
end
