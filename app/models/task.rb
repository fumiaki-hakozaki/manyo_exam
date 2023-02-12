class Task < ApplicationRecord
  validates :task_name, :task_content, :status, :priority, :deadline, presence: true
  validates :task_name, :task_content, length:{ minimum: 1 }
  enum status:{ '未着手':0, '着手中':1, '完了':2 }
  enum priority:{ '低':0, '中':1, '高':2 }
  scope :sort_priority, ->{order(priority: :DESC)}
  scope :default_order, ->{order(created_at: :DESC)}

  scope :search_status, -> (status){
    return if status.blank?
    where(status: status)
  }

  scope :search_name, -> (task_name){
    return if task_name.blank?
    where('task_name LIKE ?', "%#{task_name}%")
  }

  scope :search_label, -> (label_id) {
    return if label_id.blank?
    where(id: TaskLabel.where(label_id: label_id).pluck(:task_id))
  }

  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels , through: :task_labels
end
