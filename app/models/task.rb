class Task < ApplicationRecord
  validates :task_name, :task_content, :status, :priority, :deadline, presence: true
  validates :task_name, :task_content, length:{ minimum: 1 }
  enum status:{ '未着手':0, '着手中':1, '完了':2 }

  scope :search_status, -> (status){
    return if status.blank?
    where(status: status)
  }

  scope :search_name, -> (task_name){
    return if task_name.blank?
    where('task_name LIKE ?', "%#{task_name}%")
  }
end
