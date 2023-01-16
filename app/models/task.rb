class Task < ApplicationRecord
  validates :task_name, :task_content, :status, :priority, :deadline, presence: true
  validates :task_name, :task_content, length:{ minimum: 1 }
  enum status:{ '未着手':0, '着手中':1, '完了':2 }
end
