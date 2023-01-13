class Task < ApplicationRecord
  validates :task_name, :task_content, :status, :priority, :deadline, presence: true
  validates :task_name, :task_content, length:{ minimum: 1 }
end
